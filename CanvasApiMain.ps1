<#
 https://github.com/squid808/
 Use at your own risk and stuff

 This project contains the main methods for the Canvas APIs as well
 as a number of test methods. See the method generator for more potential.

 Based on https://canvas.instructure.com/doc/api/index.html
#>

#region Base Canvas API Methods
function Get-CanvasCredentials(){
    if ($global:CanvasApiTokenInfo -eq $null) {
    
        $ApiInfoPath = "$env:USERPROFILE\Documents\CanvasApiCreds.json"

        #TODO: Once this is a module, load it from the module path: $PSScriptRoot or whatever that is
        if (-not (test-path $ApiInfoPath)) {
            $Token = Read-Host "Please enter your Canvas API API Access Token"
            $BaseUri = Read-Host "Please enter your Canvas API Base URI (for example, https://domain.beta.instructure.com)"

            $ApiInfo = [ordered]@{
                Token = $Token
                BaseUri = $BaseUri
            }

            $ApiInfo | ConvertTo-Json | Out-File -FilePath $ApiInfoPath
        }

        #load the file
        $global:CanvasApiTokenInfo = Get-Content -Path $ApiInfoPath | ConvertFrom-Json
    }

    return $global:CanvasApiTokenInfo
}

function Get-CanvasAuthHeader($Token) {
    return @{"Authorization"="Bearer "+$Token}
}

function Get-CanvasApiResult(){

    Param(
        $Uri,

        $RequestParameters,

        [ValidateSet("GET", "POST", "PUT", "DELETE")]
        $Method="GET"
    )

    $AuthInfo = Get-CanvasCredentials

    if ($RequestParameters -eq $null) { $RequestParameters = @{} }

    $RequestParameters["per_page"] = "10000"

    $Headers = (Get-CanvasAuthHeader $AuthInfo.Token)

    try {
    $Results = Invoke-WebRequest -Uri ($AuthInfo.BaseUri + $Uri) -ContentType "multipart/form-data" `
        -Headers $headers -Method $Method -Body $RequestParameters 
    } catch {
        throw $_.Exception.Message
    }

    $Content = $Results.Content | ConvertFrom-Json

    #Either PSCustomObject or Object[]
    if ($Content.GetType().Name -eq "PSCustomObject") {
        return $Content
    }

    $JsonResults = New-Object System.Collections.ArrayList

    $JsonResults.AddRange(($Results.Content | ConvertFrom-Json))

    if ($Results.Headers.link -ne $null) {
        $NextUriLine = $Results.Headers.link.Split(",") | where {$_.Contains("rel=`"next`"")}

        $PerPage = $NextUriLine.Substring($NextUriLine.IndexOf("per_page=")+9) -replace '(\D).*',""

        if (-not [string]::IsNullOrWhiteSpace($NextUriLine)) {
            while ($Results.Headers.link.Contains("rel=`"next`"")) {
        
                $nextUri = $Results.Headers.link.Split(",") | `
                            where {$_.Contains("rel=`"next`"")} | `
                            % {$_ -replace ">; rel=`"next`""} |
                            % {$_ -replace "<"}
        
                #Write-Progress
                Write-Host $nextUri
        
                $Results = Invoke-WebRequest -Uri $nextUri -Headers $headers -Method Get -Body $RequestParameters -ContentType "multipart/form-data" `
    
                $JsonResults.AddRange(($Results.Content | ConvertFrom-Json))
            }
        }
    }

    return $JsonResults
}

#endregion