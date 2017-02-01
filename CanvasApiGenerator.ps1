<#
 https://github.com/squid808/
 Use at your own risk and stuff

 The main method is Generate-CanvasAPIs, which will call the URL for the canvas API website
 and proceed to parse it out, generating the PowerShell Client APIs for it.

 The page it parses: https://canvas.instructure.com/doc/api/all_resources.html#method.admins.destroy
#>

#Take in the HTML for a method, and spit out the formatted code to make a method for it.
function Write-CanvasAPI($Method) {
    $HttpMethod, $Endpoint = ($Method.getElementsByClassName("endpoint") `
        | select -first 1).innerText.Split(" ")

    $Endpoint = $Endpoint -join ""
    
    $Description = $Method.childNodes | where {$_.tagName -eq "p"} `
        | select -ExpandProperty innerText

    $PathParams = if ($Endpoint.Contains(":")) {
            $Endpoint.Split("/") | where {$_ -like ":*"} | % {(ToProper $_.Replace(":","")).Replace("_","")}
        }

    $Synopsis = $Method.getElementsByClassName("api_method_name").item().getElementsByTagName("a").item().innerText
    
    $QueryParams = Parse-CanvasApiQueryParams $Method

    $Verb = ToProper $HttpMethod

    $Noun = "Canvas" + (Get-CanvasNounFromEndpoint $Endpoint)
    
    $PoshMethod = "$Verb-$Noun"

    $Example = Make-CanvasApiExample $PoshMethod $PathParams $QueryParams

    $Params = Format-CanvasApiParams $PathParams $QueryParams

    $UriWithParams = Make-CanvasApiUriWithParams $Endpoint $PathParams

    $Body = Make-CanvasApiBody $QueryParams

    $ReturnLine = "return Get-CanvasApiResult `$uri -Method $HttpMethod"

    if ($Body -ne $null) {$ReturnLine += " -RequestParameters `$Body"}

    $functionText = @"
<#
.Synopsis
   $Synopsis
.DESCRIPTION
   $Description
.EXAMPLE
   $Example
#>
function $PoshMethod {
[CmdletBinding()]$Params

    $UriWithParams $Body

    $ReturnLine
}


"@

    return $functionText
}

#Makes the strings to represent the query parameters in the form of the body
function Make-CanvasApiBody($QueryParams){
    if ($QueryParams -ne $null){
        $result = New-Object System.Collections.ArrayList

        $result.Add("`r`n`r`n`t`$Body = @{}") | Out-Null

        foreach ($Q in $QueryParams) {
            $N = $Q.name
            $O = $Q.originalName

            if ($Q.required) {
                $result.Add("`$Body[`"$O`"] = `$$N") | Out-Null
            } else {
                $result.Add("if (`$$N) {`$Body[`"$O`"] = `$$N}") | Out-Null
            }
        }

        return $result -join "`r`n`r`n`t"
    }
}

#Makes the line that creates the URI variable, eg $uri = ...
function Make-CanvasApiUriWithParams($Endpoint, $PathParams){
    
    $FormattedEndpoint = Parse-CanvasApiEndpointPath $Endpoint

    $uriLine = '$uri = "' + $FormattedEndpoint + '"'

    if ($PathParams -ne $null) {
        $uriLine += " -f "

        $ParamString = New-Object System.Collections.ArrayList

        foreach ($P in $PathParams) {
            $ParamString.Add("`$$P") | Out-Null
        }

        $uriLine += $ParamString -join ", "
    }

    return $uriLine
}

#Creates the parameter list for the cmdlet
function Format-CanvasApiParams($PathParams, $QueryParams) {
    $paramstring = @"
        # {0}
        [Parameter(Mandatory=`${1})]
        `${2}
"@

    if ($PathParams -ne $null -or $QueryParams -ne $null){
    
        $results = New-Object System.Collections.ArrayList

        foreach ($P in $PathParams) {
            $results.Add(($paramstring -f "The $P", 'true', "$P")) | Out-Null
        }

        foreach ($Q in $QueryParams) {
            $results.Add(($paramstring -f ($Q.description -replace "`r`n","`r`n`t`t#"), `
                $Q.required.ToString().ToLower(), $Q.name)) | Out-Null
        }

        $combined = $results -join ",`r`n`r`n"

        return "`r`n`r`n`tParam`r`n`t(`r`n" + $combined + "`r`n`t)"
    }
}

#Sets a string to uppercase, with an option to remove underscores
function ToProper($String,$RemoveUnderscores=$false) {

    if ($RemoveUnderscores) {
        return ($String.Split("_") `
            | %{(Get-Culture).TextInfo.ToTitleCase($_.ToLower())}) -join ""

    } else {
        return (Get-Culture).TextInfo.ToTitleCase($String.ToLower())
    }
}

#Creates the example text for the cmdlet
function Make-CanvasApiExample($Method, $PathParams, $QueryParams){
    $ex = "PS C:> $Method"

    foreach ($P in $PathParams) {
        $ex += (" -" + $P + " `$Some$P" + "Obj")
    }

    foreach ($Q in $QueryParams) {
        $ex += (" -" + $Q.name + " `$Some" + $Q.name + "Obj")
    }

    return $ex
}

#Get a list of request params from the method
function Parse-CanvasApiQueryParams($Method){
    $results = new-object System.Collections.ArrayList

    $paramsHtml = $Method.getElementsByClassName("request-param")

    foreach ($p in $paramsHtml){
        
        if ($p.childNodes[0].innerText -Match "\[.+\]"){
            $name = ToProper ($p.childNodes[0].innerText -replace ".*\[","" -replace "\]","") $true
            $parent = ToProper ($p.childNodes[0].innerText -replace "\[.*","") $true
        } else {
            $name = $p.childNodes[0].innerText
        }

        $obj = New-Object psobject -Property ([ordered]@{
            name = $name
            originalName = $p.childNodes[0].innerText
            parent = $parent
            required = if (-not [string]::IsNullOrWhiteSpace($p.childNodes[1].innerText)) {$true} else {$false}
            type = ToProper $p.childNodes[2].innerText
            description = $p.childNodes[3].innerText
            isCollection = $false
        })

        if ($p.childNodes[0].innerText -match "\[\]"){
            $obj.name = ToProper ($p.childNodes[0].innerText -replace "\[\]","") $true
            $obj.isCollection = $true
        }

        $results.Add($obj) | Out-Null
    }

    return $results
}

#Pulls the Cmdlet Noun from the Endpoint
function Get-CanvasNounFromEndpoint($Endpoint){
    $result = ""
    
    foreach($E in ($Endpoint.Replace("/api/v1/","").Split("/"))) { 
        if (-not ($E.Contains(":") -or $E.Contains("*"))){
            if ($E.Contains("_")){
                $E.Split("_") | %{$result += (ToProper $_)}
            } else {
                $result += ToProper $E
            }
        }
    }

    return $result -replace "[^a-zA-Z]"
}

#Formats the Endpoint for the Cmdlet with string formatting ready
function Parse-CanvasApiEndpointPath($Endpoint){
    $ind = 0
    $Endpoints = $Endpoint.Split("/")
    
    for ($i = 0; $i -lt $Endpoints.Count; $i++){
        if ($Endpoints[$i].Contains(":") -or $Endpoints[$i].Contains("*")){
            $Endpoints[$i] = "{$ind}"
            $ind++
        }
    }

    return $Endpoints -join "/"
}

#Parse through the canvas API website and generate the methods based on that
function Generate-CanvasAPIs (){
    $RiskHeader = @"
<#

I shold write something here to put in the beginning of the 
generated file so you know I did all the hard work.
  -squid808


#>   
"@ 

    #Get the page HTML
    $CanvasApiPage = Invoke-WebRequest https://canvas.instructure.com/doc/api/all_resources.html

    #Get the methods from the page
    $Methods = $CanvasApiPage.ParsedHtml.getElementsByTagName("div") | `
        where {$_.className -like "method_details*" -and $_.className -notlike "*_list"}

    $Generated = New-Object System.Collections.ArrayList

    $Methods | %{Write-CanvasAPI $_} | %{$Generated.Add($_) | Out-Null}

    return $Generated
}

#Example usage
#$Apis = Generate-CanvasAPIs
# Generate-CanvasAPIs | Set-Clipboard