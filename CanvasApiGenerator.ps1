<#
 https://github.com/squid808/
 Use at your own risk and stuff.

 The main method is Generate-CanvasApi, which will parse the Canvas Swagger file(s) and generate
 the cmdlets based on that. It's up to you to do what you want with the file, but see a suggested
 example at the bottom.

 The verbs of the cmdlets are generated from the API Method - GET, PUT, POST, DELETE. I realize
 these aren't posh-friendly, but it's not about PoSh, it's about usability.

 The nouns of the cmdlets generated are based on the information in the Canvas API, and duplicates
 are resolved with the information from the API URI, so if the URI path of a duplicate is:
   /v1/accounts/{account_id}/users/{user_id}/account_notifications

 The cmdlet noun will be:
   AccountsUsersAccountNotificationsByAccountIdAndUserId

 This will remain until someone can come up with a better way to do it :D

#>

$BaseUri = "https://canvas.instructure.com/doc/api"

#region Helpers

function ConvertTo-TitleCase ($String, $Delimiter){
    $String = $String.ToLower()
    
    if ($Delimiter -ne $null){
        return ($String.Split($Delimiter) | %{(Get-Culture).TextInfo.ToTitleCase($_)}) -join ""
    } else {
        return (Get-Culture).TextInfo.ToTitleCase($String)
    }
}

function ConvertTo-Acronym ($String, $Delimiter){
    return ($String.Split($Delimiter) | %{$_.ToUpper()[0]}) -join ""
}

#endregion

#region Info Gathering
function Get-AllApiDocs ($BaseUri) {
    $ApisList = Invoke-RestMethod -Uri "$BaseUri/api-docs.json"

    $ApisHash = @{}

    $ApisList | Add-Member -MemberType NoteProperty -Name "apiHash" -Value $ApisHash

    foreach ($SubApiList in $ApisList.apis) {
        $Result = (Invoke-RestMethod -Uri ($BaseUri + $SubApiList.path))
        $Result | Add-Member -MemberType NoteProperty -Name "parent" -Value $ApisList

        $ApisHash.Add($SubApiList.Description.Replace(" ",""),$Result) | Out-Null
        $SubApiList | Add-Member -MemberType NoteProperty -Name "api" -Value $Result

        foreach ($Api in $SubApiList.api.apis) {
            $Api | Add-Member -MemberType NoteProperty -Name "parent" -Value $SubApiList
        }
    }

    return $ApisList
}

function Get-AllModelObjects ($Apis) {
    
    $Models = @{}

    foreach ($Api in $Apis) {
        if (($Api.models.PSObject.Properties | measure | select -ExpandProperty Count) -gt 0){
        
            foreach ($M in $Api.models.PSObject.Properties){
                $Models.Add($M.Name, $M.Value) | Out-Null
            }
        }
    }

    return $Models
}

function Get-AllMethodObjects($Apis){
    
    $Methods = New-Object System.Collections.ArrayList

    foreach ($Api in $Apis) {

        $ApiAcronym = ConvertTo-Acronym

        if ($Api.apis.Count -gt 0){
        
            foreach ($M in $Api.apis){
                $Methods.Add($M) | Out-Null
            }
        }
    }

    return $Methods

}

function Get-CanvasApiData ($BaseUri) {

    $Docs = Get-AllApiDocs $BaseUri



}
#endregion

#region Methods

function Convert-MethodToPosh ($Method) {
    $MethodName = New-MethodName $Method

    $String = @'
<#
.Synopsis
   {0}
.EXAMPLE
   {6}
#>
function {1} {{{{
[CmdletBinding()]
{2}

    $Uri = "/api{3}"

    {4}

    return Get-CanvasApiResult $Uri -Method {5} -RequestParameters $Body

}}}}
'@ -f ($Method.description -replace "{","[" -replace "}","]"),
        '{0}',
        (Convert-MethodParamsToString $Method),
        (Convert-MethodUri $Method),
        (New-MethodBody $Method),
        $Method.operations.method,
        (New-MethodExample $Method)

    return New-Object -TypeName psobject -Property (@{
        name = $MethodName
        body = $string
    })
}

function New-MethodExample ($Method, $MethodName) {

    $string = 'PS C:> {0}'

    if (($Method.operations.parameters | where {$_.required -eq $True} `
        | Measure-Object | select -ExpandProperty Count) -eq 0) {
        return $string
    }

    $params = New-Object System.Collections.ArrayList
    
    foreach ($P in $Method.operations.parameters) {
        if ([bool]::Parse($P.required)) {
            $PName = Convert-ParamNameToPoshString $P.name
            $params.Add('-{0} $Some{0}Obj' -f $PName) | Out-Null
        }
    }

    $string += " " + $params -join " "

    return $string
}

function New-MethodBody ($Method) {
    if ($Method.operations.parameters.Count -eq 0) { return $null }

    $Params = New-Object System.Collections.ArrayList

    foreach ($P in $Method.operations.parameters){
        $Params.Add((New-MethodBodyParameter $P)) | Out-Null
    }

    $string = @'
$Body = @{{{{}}}}

{0}

'@ -f ($Params -join "`r`n`r`n")

    return $string
}

function New-MethodBodyParameter($Parameter) {

    $ParamTitle = Convert-ParamNameToPoshString $Parameter.name
    
    $string = '$Body["{0}"] = ${1}' -f $Parameter.name, $ParamTitle

    if (-not [bool]::Parse(($Parameter.required))) {
        $string = 'if (${0}) {{{{ {1} }}}}' -f $ParamTitle, $string
    }

    return "`t" + $string
}

#Get a string with Powershell variables in place of doc variables
function Convert-MethodUri ($Method){
    $Paths = $Method.path.Split("/")

    for ($i = 0; $i -lt $Paths.Length; $i++){
        if ($Paths[$i][0] -eq '{' -and $Paths[$i][-1] -eq '}'){
            $Paths[$i] = '$' + (ConvertTo-TitleCase $Paths[$i].Replace('{','').Replace('}','') -Delimiter "_")
        }
    }

    return $Paths -join "/"
}

#Creates the name of a PoSh function for a method call
function New-MethodName ($Method){
    $Verb = ConvertTo-TitleCase $Method.operations.method
    
    $End = if ($Method.path.Split("/")[-1] -match "{.*}") {
        "By" + (ConvertTo-TitleCase ($Method.path.Split("/")[-1] -replace "[{}]",""))
    }

    $Type = $Method.operations.type
    $Ref = $Method.operations.items.'$ref'

    $Noun = if ($Type -eq "void") {
        Get-MethodResourcePath $Method
    } else {
        if ($Type -eq "array" -and $Ref -ne $null) {
            $Method.operations.items.'$ref'
        } else {
            Get-MethodResourcePath $Method
        }
    }

    $Name = ($Verb + "-Canvas" + $Noun + $End) -replace "_",""

    return $Name
}

function Get-MethodResourcePath ($Method){
    return (ConvertTo-TitleCase $Method.parent.api.resourcePath.Replace("/","") -Delimiter "_")
}

#endregion

#region Method Parameters

#Convert all the params in a method to a param block
function Convert-MethodParamsToString ($Method) {

    if ($Method.operations.parameters.Count -eq 0) { return $null }
    
    $Params = $Method.operations.parameters

    $ParamsString = New-Object System.Collections.ArrayList

    foreach ($P in $Params){
        $ParamsString.Add((New-MethodParamString $P)) | Out-Null
    }

    $ParamString = @'
    Param (
{0}
    )
'@ -f ($ParamsString -join ",`r`n`r`n")


    return $ParamString
}

#Create a string for a single param from a method
function New-MethodParamString ($Param) {
    $PString =  @'
        # {0}
        [Parameter(Mandatory=${1})]
        {3} ${2}
'@ -f (Format-ParamDescription $Param.description), $Param.required, (Convert-ParamNameToPoshString $Param.name),
    (Get-MethodParamTypeForPosh $Param)

    return $PString
}

#removes the description's curly brackets and adds a hash tag to the beginning of each line
function Format-ParamDescription ($ParamDescription){
    $ParamDescription = $ParamDescription.Split("`r`n") -join "`r`n`t`t# " -replace "{","[" -replace "}","]"

    return $ParamDescription
}

#remove non-alphanumeric characters from the string
function Convert-ParamNameToPoshString ($ParamName){
    (ConvertTo-TitleCase $ParamName "_") -replace "\W|_",""
}

#Converts known object types to the posh types, for method parameters
function Get-MethodParamTypeForPosh ($Param){
    switch ($Param.type){
        "Float" { "[float]" }
        "string" { "[string]" }
        "boolean" {"[bool]"}
        "integer" {"[int]"}
        default {$null}
    }
}

#Takes a method and provides a new method name by path.
function MakeUniqueCmdletName($Method){
    $Words = @()
    $Params = @()
    $Split = $Method.method.path.Split("/")

    for ($i = 2; $i -lt $Split.Count; $i++){
    #foreach ($P in $Split){
        if ($Split[$i] -match"{.*}"){
            $Params += (ConvertTo-TitleCase ($Split[$i] -replace "[{}]","") "_")
        } elseif (-not [string]::IsNullOrWhiteSpace($Split[$i])){
            $Words += (ConvertTo-TitleCase $Split[$i] "_")
        }
    }

    $Noun = ($Words -join "")
    if ($Params.Count -gt 0) {
        $Noun += ("By" + ($Params -join "And"))
    }

    $Noun = $Noun -replace "_",""

    return (ConvertTo-TitleCase $Method.method.operations.method.ToLower()) + "-Canvas" + $Noun
}

#endregion

function Generate-CanvasApi ($ResultPath) {
    #Gather all of the API information from the Swagger Resources
    $Api = Get-AllApiDocs $BaseUri

    $PoshMethodsInOrder = New-Object System.Collections.ArrayList
    $MethodsByName = @{}
    $Regions = @{}

    #Format each method into a string ready to be formatted with the cmdlet name, once we establish it
    foreach ($A in $Api.apis) {

        foreach ($Method in $A.api.apis){
            $M = (Convert-MethodToPosh $Method)
            $M | Add-Member -MemberType NoteProperty -Name "method" -Value $Method
            $PoshMethodsInOrder.Add($M) | Out-Null
            if (-not $MethodsByName.ContainsKey($M.name)){
                $MethodsByName.Add($M.name, (New-Object System.Collections.ArrayList)) | Out-Null
            }
            $MethodsByName[$M.name].Add($M) | Out-Null
        }
    }

    #now find any duplicate cmdlet names, make those unique and throw them in to a region collection
    foreach ($M in $PoshMethodsInOrder) {
        if ($MethodsByName[$M.name].Count -gt 1){
            $M.name = MakeUniqueCmdletName $M
        }

        if (-not $Regions.ContainsKey($M.method.parent.description)){
            $Regions.Add($M.method.parent.description, (New-Object System.Collections.ArrayList))
        }

        $Regions[$M.method.parent.description].Add(($M.body -f $M.name)) | Out-Null
    }

    #Now create the document
    $Doc = New-Object System.Collections.ArrayList

    $Doc.Add(@"
<#

Generated by the Canvas PowerShell API Generator, by Spencer Varney

{0}

Use at your own risk!

#>
"@ -f (Get-Date))

    #Add the manually created main API call methods
    $CM = get-content .\CanvasApiMain.ps1
    $Doc.Add($CM[($CM.IndexOf("#>") + 2)..($CM.Length-1)] -join "`r`n") | Out-Null

    #Add and compile each of the regions
    foreach ($K in ($Regions.Keys | Sort)) {
        $Doc.Add(("#region $K`r`n`r`n" + ($Regions[$K] -join "`r`n`r`n") + "`r`n`r`n#endregion")) | Out-Null
    }

    $Doc = $Doc -join "`r`n`r`n"

    return $Doc
}

<#
 $Generated = Generate-CanvasApi
 $Generated | Out-File ".\PoshCanvas.ps1"
 or
 $Generated | Set-Clipboard
#>