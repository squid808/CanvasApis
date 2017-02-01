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

        [ValidateSet("GET","POST", "PUT", "DELETE")]
        $Method="GET"<#,

        [switch]$Parallel, #TODO: get this working better

        [int]$BatchSize=5 #TODO: this goes with parallel#>
    )

    $AuthInfo = Get-CanvasCredentials

    if ($RequestParameters -eq $null) { $RequestParameters = @{} }

    #$RequestParameters["per_page"] = "10000"

    try {
    $Results = Invoke-WebRequest -Uri ($AuthInfo.BaseUri + $Uri) `
        -Headers (Get-CanvasAuthHeader $AuthInfo.Token) -Method $Method -Body $RequestParameters `
        -ErrorAction SilentlyContinue
    } catch {
        throw $_.Exception.Message
    }
    #if (-not $Results) {
    #    throw $Error[0].Exception
    #}

    $Content = $Results.Content | ConvertFrom-Json

    #Either PSCustomObject or Object[]
    if ($Content.GetType().Name -eq "PSCustomObject") {
        return $Content
    }

    $JsonResults = New-Object System.Collections.ArrayList

    $JsonResults.AddRange(($Results.Content | ConvertFrom-Json))

    if ($Results.Headers.link -ne $null) {
        $LastUriLine = $Results.Headers.link.Split(",") | where {$_.Contains("rel=`"last`"")}

        $LastPageNum = $LastUriLine.Substring($LastUriLine.IndexOf("page=")+5) -replace '(\D).*',""

        $PerPage = $LastUriLine.Substring($LastUriLine.IndexOf("per_page=")+9) -replace '(\D).*',""

        if ($LastPageNum -ne 1) {
            #if (-not $Parallel){ 
                while ($Results.Headers.link.Contains("rel=`"next`"")) {
        
                    $nextUri = $Results.Headers.link.Split(",") | `
                                where {$_.Contains("rel=`"next`"")} | `
                                % {$_ -replace ">; rel=`"next`""} |
                                % {$_ -replace "<"}
        
                    #Write-Progress
                    Write-Host $nextUri
        
                    $Results = Invoke-WebRequest -Uri $nextUri -Headers $headers -Method Get -Body $RequestParameters
    
                    $JsonResults.AddRange(($Results.Content | ConvertFrom-Json))
                }
            <#} else {
                workflow Get-RemainingParallel($Uris, $Body, $Headers, $Token, $Method) {
        
                    foreach -parallel ($item in $Uris)
                    {
                        sequence {
                            inlinescript {Write-Host $using:item}
                            #inlinescript {
                            #    Invoke-WebRequest -Uri $using:item -Headers $using:headers -Method $using:Method -Body $using:Body
                            #}

                            (Invoke-WebRequest -Uri $item -Headers $headers -Method $Method -Body $Body).Content | ConvertFrom-Json
                        }
                    }
                }

                $Uris = New-Object System.Collections.ArrayList

                for ($i = 2; $i -le $LastPageNum; $i++) {
                    $Uris.Add(("{0}{1}?page={2}&per_page={3}" -f $AuthInfo.BaseUri, $Uri, $i, $PerPage)) | Out-Null
                }

                #for ($i=0; $i-le 2; $i+=$BatchSize){
                for ($i=0; $i -lt $LastPageNum-1; $i+=$BatchSize){

                    if ($i + $BatchSize -gt $LastPageNum) {
                        $Batch = $Uris[$i..($Uris.Count-1)]
                    } else {
                        $Batch = $Uris[$i..($i+$BatchSize-1)]
                    }

                    $ParallelResults = Get-RemainingParallel $Batch $RequestParameters $headers $Token $Method
                
                    if ($ParallelResults.GetType().Name -eq "Object[]") {
                        foreach ($result in $ParallelResults){
                            $JsonResults.AddRange($result)
                        }
                    } else {
                        foreach ($result in $ParallelResults){
                            $JsonResults.Add($result) | Out-Null
                        }
                    }

                }
            } #>
        }
    }

    return $JsonResults
}
#endregion

###################

#region Some quickly thrown together methods

function Get-CanvasUser($AccountId, $SearchTerm, [switch]$Parallel){
    $Uri = "/api/v1/accounts/$AccountId/users"

    if (-not [string]::IsNullOrWhiteSpace($SearchTerm)) {
        $RequestParams = @{"search_term"=$SearchTerm}
    }

    return (Get-CanvasApiResult $Uri $RequestParams -Parallel:$Parallel)
}

function Get-CanvasUserCourses($UserId) {
    $uri = "/api/v1/users/$UserId/courses"

    return (Get-CanvasApiResult -Uri $uri)
}

function Get-CanvasCourse ($CourseId) { return Get-CanvasApiResult "/api/v1/courses/$CourseId/" }

function Get-CanvasCourseUsers($CourseId){ return Get-CanvasApiResult "/api/v1/courses/$CourseId/users" }

function Get-CanvasCourseStudents($CourseId){ return Get-CanvasApiResult "/api/v1/courses/$CourseId/students" }

function Get-CanvasCourseRecentlyLoggedInStudents($CourseId){ return Get-CanvasApiResult "/api/v1/courses/$CourseId/recent_students" }

function Get-CanvasCourseActivityStream($CourseId){ return Get-CanvasApiResult "/api/v1/courses/$CourseId/activity_stream" }

function Get-CanvasCourseActivityStreamSummary($CourseId){ return Get-CanvasApiResult "/api/v1/courses/$CourseId/activity_stream/summary" }

#doesnt include the id
function Get-CanvasCourseParticipationData($CourseId) { return Get-CanvasApiResult "/api/v1/courses/$CourseId/analytics/activity" }

function Get-CanvasCourseStudentSummaryData($CourseId){ return Get-CanvasApiResult "/api/v1/courses/$CourseId/analytics/student_summaries" }

function Get-CanvasCourseAssignmentData($CourseId) { return Get-CanvasApiResult "/api/v1/courses/$CourseId/analytics/assignments" }

function Get-CanvasUserAssignments($UserId, $CourseId){ return Get-CanvasApiResult "/api/v1/users/$UserId/courses/$CourseId/assignments" }

#can take in 'bucket' to only pull in past or more
function Get-CanvasCourseAssignments() {
    param (
        $CourseId,
        
        [ValidateSet("past","overdue","undated","ungraded","unsubmitted","upcoming","future")]
        $Bucket
    )

    $Body = @{}

    if ($Bucket) {
        $body["bucket"] = $Bucket
    }

    return Get-CanvasApiResult "/api/v1/courses/$CourseId/assignments" -RequestParameters $Body
}

#Returns a list of assignments for the course sorted by due date. For each assignment 
#returns basic assignment information, the grade breakdown (including the student's actual grade), 
#and the basic submission information for the student's submission if it exists.
function Get-CourseUserAssignmentData($CourseId, $UserId){
    return Get-CanvasApiResult "/api/v1/courses/$CourseId/analytics/users/$UserId/assignments"
}

function Get-CourseUserParticipationData($CourseId, $UserId){
    return Get-CanvasApiResult "/api/v1/courses/$CourseId/analytics/users/$UserId/activity"
}

function Get-CourseUserMessagingData($CourseId, $UserId){
    return Get-CanvasApiResult "/api/v1/courses/$CourseId/analytics/users/$UserId/communication"
}

function Get-CanvasTerms(){ return Get-CanvasApiResult "/api/v1/accounts/1/terms" }

function New-CanvasCourseCopy($SourceCourseId, $TargetCourseId) {
    $Body = @{
    "migration_type"="course_copy_importer";
    "settings[source_course_id]" = $SourceCourseId
    }

    return Get-CanvasApiResult "/api/v1/courses/$TargetCourseId/content_migrations" -RequestParameters $Body -Method POST
}

function Get-CanvasCourseCopy($TargetCourseId, $MigrationId){
    return Get-CanvasApiResult "/api/v1/courses/$TargetCourseId/content_migrations/$MigrationId"
}

#endregion