<#
 https://github.com/squid808/
 Use at your own risk and stuff

 This project contains wrapper methods for the Canvas Data APIs as well
 as a number of helper methods.

 Based on https://portal.inshosteddata.com/docs/api
#>

#Set the location back after importing sql
$loc = get-location
ipmo sqlps -DisableNameChecking
Set-Location $loc

#region Canvas Data API Endpoint Wrappers

#Load up the credentials, or prompt the user for them if they don't exist.
function Get-CanvasDataCredentials(){
    if ($global:CanvasDataKeyInfo -eq $null) {
    
        $KeyPath = "$env:USERPROFILE\Documents\CanvasDataApiCreds.json"

        #TODO: Once this is a module, load it from the module path: $PSScriptRoot or whatever that is
        if (-not (test-path $KeyPath)) {
            $ApiKey = Read-Host "Please enter your Canvas API Key"
            $ApiSecret = Read-Host "Please enter your Canvas API Secret"

            $KeyInfo = [ordered]@{
                Key = $ApiKey
                Secret = $ApiSecret
            }

            $KeyInfo | ConvertTo-Json | Out-File -FilePath $KeyPath
        }

        #load the file
        $global:CanvasDataKeyInfo = Get-Content -Path $KeyPath | ConvertFrom-Json
    }

    return $global:CanvasDataKeyInfo
}

#Return an appropriate header for Canvas Data API calls
function Get-CanvasDataHeader($ApiUri, $QueryParams){

    $KeyInfo = Get-CanvasDataCredentials

    $date = [DateTime]::UtcNow.ToString("R")

    if ($QueryParams) {
        $QueryParamsString = ($QueryParams.GetEnumerator() | Sort-Object -Property Name | ForEach-Object {$_.Key + "=" + $_.Value}) -join "&"
    }

    $message = "GET`nportal.inshosteddata.com`n`n`n$ApiUri`n$QueryParamsString`n$date`n" + $KeyInfo.Secret

    $hmacsha = New-Object System.Security.Cryptography.HMACSHA256
    $hmacsha.key = [Text.Encoding]::ASCII.GetBytes($KeyInfo.Secret)
    $signature = $hmacsha.ComputeHash([Text.Encoding]::ASCII.GetBytes($message))
    $signature = [Convert]::ToBase64String($signature)

    $header = [ordered]@{
        "Authorization"="HMACAuth " + $KeyInfo.Key + ":"+$signature
        "Date" = $date
    }

    return $header
}

#Return a generic Canvas Data result - this is the main API call base
function Get-CanvasDataApiResult {
    param(
        $Uri,

        $Body,

        $Method = "GET"
    )

    $BaseUri = "https://portal.inshosteddata.com"

    $Header = Get-CanvasDataHeader $Uri $Body

    $Result = (Invoke-WebRequest -Uri ($BaseUri + $Uri) -Headers $header -Method $Method -Body $Body -UseBasicParsing) | ConvertFrom-Json

    return $Result
}

#Returns a list of canvas data dumps order by the most recent dumps first
function Get-CanvasDataAccountDump {
    param (
        [int]$After,

        [int]$Limit, #canvas defaults to 50
        
        $AccountId="self"
    )

    $Body = @{}

    if ($After) { $Body["after"]=$After }
    if ($Limit) { $Body["limit"]=$Limit }
    
    return Get-CanvasDataApiResult "/api/account/$AccountId/dump" $Body
}

#Retrieves a list of expiring URLs for the latest dump, for the given dump id, or for a given table
#(ordered by the most recent dump first) that can be downloaded
function Get-CanvasDataExpiringUrls {
[CmdletBinding(DefaultParameterSetName="Latest")]

    param (
        [Parameter(ParameterSetName="ByDump",Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$DumpId,

        [Parameter(ParameterSetName="ByTable",Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$TableName,

        [Parameter(ParameterSetName="ByTable")]
        [int]$After,

        [Parameter(ParameterSetName="ByTable")]
        [int]$Limit,
        
        [Parameter(ParameterSetName="Latest")]
        [Parameter(ParameterSetName="ByTable")]
        [Parameter(ParameterSetName="ByDump")]
        $AccountId="self"
    )
    $Uri = "/api/account/$AccountId/file"

    $Body = @{}

    if ($PsCmdlet.ParameterSetName -eq "Latest") {$Uri += "/latest"}
    if ($PsCmdlet.ParameterSetName -eq "ByDump") {$Uri += "/byDump/$DumpId"}
    if ($PsCmdlet.ParameterSetName -eq "ByTable") {
        $Uri += "/byTable/$TableName"
        if ($After) { $Body["after"]=$After }
        if ($Limit) { $Body["limit"]=$Limit }
    }

    return Get-CanvasDataApiResult $Uri -Body $Body
}

#Retrieve a list of files and signed URLs that constituite a complete snapshot of the current data, 
#including all partial dumps up until the last full dump. Option to download and process the data,
#returned in a table by file name
function Get-CanvasDataSync {
    param (
        $AccountId="self",

        $DumpPath,

        [switch]$ReturnData
    )

    $sync = Get-CanvasDataApiResult "/api/account/$AccountId/file/sync"

    if (-not $ReturnData) {
        return $sync
    } else {

        $counter = 0
            
        foreach ($url in $sync.files) {
            $file = (($url.url -split "filename%3D%22")[1] -split ".gz")[0]
    
            $uniqueName = $file.Split("-")[0]

            Write-Progress -Activity "Downloading sync files: $file" `
                -Status ("Retrieving file " + ($counter + 1)) `
                -PercentComplete ($counter/$sync.files.Count * 100)
            $wc = New-Object System.Net.WebClient
                
            #$download = $wc.DownloadData($url.url)
            
            Write-Progress -Activity "Converting sync files: $file" `
                -Status ("Retrieving file " + ($counter + 1)) `
                -PercentComplete ($counter/$sync.files.Count * 100)

            $FilePath = [System.IO.Path]::Combine($DumpPath, ($file + ".txt"))

            if (-not (Test-Path $FilePath)){
                New-Item -Path $FilePath -ItemType File
            }

            #Extract-GzData $download | Out-File -FilePath $FilePath -Append -Encoding utf8
            
            $url | Add-Member -MemberType NoteProperty -Name "filePath" -Value $FilePath

            $counter++
        }
        
        #$uniqueNames = $dlResults | select -ExpandProperty name | sort | % {$_.Split("-")[0]} | select -Unique

        #$results = [ordered]@{}

        #foreach ($name in $uniqueNames) {
        #    foreach ($file in ($dlResults | where name -like ($name + "*"))) {
        #        if (-not $results.ContainsKey($name)) {
        #            $results[$name] = New-Object System.Collections.ArrayList
        #        }
        #
        #        $results[$name].AddRange($file.Data)
        #    }
        #}
        #
        #return New-Object psobject -Property $results

        Write-Progress -Activity "Downloading and processing files" -Completed

        return $sync
    }
}

#Retrieve the most recent schema and its version (default), a list of the most recent schema versions
#(with the most recent schema first), or the schema for a given version
function Get-CanvasDataSchema {
[CmdletBinding(DefaultParameterSetName="Latest")]

    param (
        [Parameter(ParameterSetName="All")]
        [switch]$All,

        [ValidateNotNullOrEmpty()]
        [Parameter(ParameterSetName="ByVersion")]
        [string]$Version
    )

    $Uri = "/api/schema"
    
    if ($PsCmdlet.ParameterSetName -eq "Latest") {$Uri += "/latest"}
    if ($PsCmdlet.ParameterSetName -eq "ByVersion") {$Uri += "/$Version"}
    
    $results = Get-CanvasDataApiResult $Uri

    foreach ($result in $results) {
        $result.version = [System.Version]$result.version
    }

    return $results | Sort-Object -Property version -Descending
}

#Use this to help validate the object coming in to a function, when it's a pscustomobject
function CheckPropertyNames([PSCustomObject]$Object, $Names){

    foreach ($Name in $Names) {
        if ($Object.PSobject.Properties.name -notcontains $Name) {
            return $false
        }
    }

    return $true
}

#Takes in the URLs, downloads and formats the tables and data in to a nice object along with the schema information.
function Get-TablesFromUrls {
[CmdletBinding(DefaultParameterSetName="Latest")]
    param (
        [Parameter(ParameterSetName="UrlsProvided")]
        [ValidateScript({CheckPropertyNames $_ "numFiles","accountId","finished",`
            "createdAt","schemaVersion","dumpId","sequence","updatedAt","expires","artifactsByTable"})]
        $ExpiringUrls,

        [Parameter(ParameterSetName="UrlsProvided")]
        [Parameter(ParameterSetName="ByVersion")]
        $Version,

        [Parameter(ParameterSetName="SchemaProvided")]
        [ValidateScript({CheckPropertyNames $_ "version","schema"})]
        $Schema
    )

    if ($PsCmdlet.ParameterSetName -eq "Latest") {
        $Schema = Get-CanvasDataSchema
        $ExpiringUrls = Get-CanvasDataExpiringUrls
    }

    if ($PsCmdlet.ParameterSetName -eq "UrlsProvided") {
        $Schema = Get-CanvasDataSchema -Version $ExpiringUrls.schemaVersion
    }

    if ($PsCmdlet.ParameterSetName -eq "SchemaProvided") {
        $ExpiringUrls = Get-CanvasDataExpiringUrls
    }

    if ($PsCmdlet.ParameterSetName -eq "ByVersion") {
        $ExpiringUrls = Get-CanvasDataExpiringUrls
        $Schema = Get-CanvasDataSchema -Version $Version
    }

    $schemaVersion = $Schema.version

    $tables = New-Object psobject -Property @{
        Tables = [ordered]@{}
        SchemaVersion = $schemaVersion
    }

    foreach ($SchemaName in (($Schema.schema | gm -MemberType NoteProperty) `
        | select -ExpandProperty name)) {
        $name = $Schema.schema.($SchemaName).tableName
        $tables.Tables[$name] = $Schema.schema.($SchemaName)
    }

    foreach ($tableName in (($ExpiringUrls.artifactsByTable | gm -MemberType NoteProperty) `
        | select name -ExpandProperty name)) {
        
        $table = $ExpiringUrls.artifactsByTable.($tableName)

        $url = $table.files.url
    
        #A byte stream in .gz format
        #$Data = Invoke-WebRequest -Uri $Url #Slower?
    
        Write-Host "Downloading $tableName..." -ForegroundColor Yellow
        $data = (New-Object System.Net.WebClient).DownloadData($Url)

        Write-Host "Converting and storing $tableName..." -ForegroundColor Yellow
        $tables.Tables[$tableName] | Add-Member NoteProperty "data" (Extract-GzData $data)
    }

    return $Tables
}

#Compare two schema versions or schema objects to return the changes
function Compare-CanvasDataSchema($Old, $New) {

    if ($old -isnot [PSCustomObject]) {
        $old = Get-CanvasDataSchema -Version $Old
    }
    if ($new -isnot [PSCustomObject]) {
        $new = Get-CanvasDataSchema -Version $New
    }

    $oldNames = $old.schema | gm -MemberType NoteProperty | select -ExpandProperty name
    $newNames = $new.schema | gm -MemberType NoteProperty | select -ExpandProperty name

    $Results = Compare-Object $oldNames $newNames

    $comparison = New-Object psobject -Property @{
        Added = New-Object System.Collections.ArrayList
        Removed = New-Object System.Collections.ArrayList
        Changed = @{}
    }

    foreach ($obj in $Results) {
        if ($obj.SideIndicator -eq "=>") {
            $comparison.Added.Add(($New.schema.($obj.InputObject))) | Out-Null
        } elseif ($obj.SideIndicator -eq "<=") {
            $comparison.Removed.Add(($Old.schema.($obj.InputObject))) | Out-Null
        }
    }

    $AllNames = $oldNames + $newNames | select -Unique

    foreach ($Name in $AllNames) {
        if ($oldNames.Contains($Name) -and $newNames.Contains($Name)) {

            $c = New-Object psobject

            foreach ($Property in ($old.schema.($Name) | gm -MemberType noteproperty `
                | select -ExpandProperty name)) {
                $diff = compare-object $old.schema.($Name) $new.schema.($Name) -Property $Property

                if ($diff -ne $null) {
                    $c | Add-Member -MemberType NoteProperty $Property $diff
                }
            }

            if (($c | gm -MemberType NoteProperty) -ne $null) {
                $c | Add-Member -MemberType NoteProperty "table" $Name
                $comparison.Changed[$Name] = $c
            }
        }
    }

    return $comparison
}

#Get a list of all schemas and returns back a list of objects detailing the changes in between each version.
function Get-CanvasDataSchemaChanges{
    $schemas = Get-CanvasDataSchema -All

    $counter = 0

    foreach ($version in $schemas) {
        Write-Progress -Activity "Gathering Schemas" -Status ("Retrieving version " + $Version.version) -PercentComplete ($counter/$schemas.Count * 100)
        $version | Add-Member NoteProperty "schema" ((Get-CanvasDataSchema -Version $version.version).schema)
        $counter++
    }

    Write-Progress -Completed -Activity "Gathering Schemas"

    $comparisons = New-Object System.Collections.ArrayList

    for ($i = 0; $i -lt $schemas.Count-1; $i++) {
        $comparisons.Add(( New-Object psobject -Property ([ordered]@{
            OldVersion = $schemas[$i+1].version
            NewVersion = $schemas[$i].version
            Description = ($schemas[$i+1].version.ToString() + " to " + $schemas[$i].version.ToString())
            Changes = (Compare-CanvasDataSchema $schemas[$i+1] $schemas[$i])
        }) )) | Out-Null
    }

    return $comparisons
}

#endregion
###################

#region Data Utils code

<#
This code is set to extract out the data from the archive files, process them and 
spit out the resulting files as efficiently as possible. Benchmarks showed that running
this same code in the PoSh equivelent was significantly slower.

This is set up specifically to format the data for a SQL server. Other needs may not be the same.
#>
$Source = @"
namespace CanvasData
{
    /// <summary>
    /// A collection of compiled utilities for use in processing the Canvas Data files.
    /// </summary>
    public class Utils
    {
        private static string nullRegexPattern = @"(?<=(^|\n|\t))\\N(?=($|\n|\t))";
        private static string nullRegexReplace = "";

        //to instead not crop the milliseconds but almost triple the time needed, use this: @"(?<=(\d\d:\d\d:\d\d.\d\d\d))(\d*)"
        private static string dateRegexPattern = @"(?<=(\d\d:\d\d:\d\d))(\.\d*)";
        private static string dateRegexReplace = "";

        private static string trueRegexPattern = @"(?<=(^|\n|\t))true(?=($|\n|\t))";
        private static string trueRegexReplace = "1";

        private static string falseRegexPattern = @"(?<=(^|\n|\t))false(?=($|\n|\t))";
        private static string falseRegexReplace = "0";

        /// <summary>
        /// Take files from a given directory path, extract them from a .gz archive and run the
        /// appropriate regex on each file.
        /// </summary>
        /// <param name="filePath">The directory that contains the files to process.</param>
        /// <param name="fileFilter">The filter used to find the files. Defaults to *.gz</param>
        /// <param name="numThreads">The number of threads to spawn pipelines for working on the files. Default 10</param>
        /// <param name="chunkSize">The number of lines from the file to process in the pipeline at each time. Default 1</param>
        /// <remarks>The number of default threads and chunks were determined by a large number of tests over many iterations on
        /// multiple machines to try and find the (generally) most efficient path.</remarks>
        public static void RunFilesAsThreads(string filePath, string fileFilter="*.gz", int numThreads = 10, int chunkSize = 1)
        {
            var filesList = System.IO.Directory.GetFiles(filePath, fileFilter);

            if (numThreads == 0) numThreads = 1;
            if (chunkSize == 0) chunkSize = 1;

            var buffer = new System.Collections.Concurrent.BlockingCollection<string>();

            foreach (var file in filesList)
            {
                buffer.Add(file);
            }

            buffer.CompleteAdding();

            var tasks = new System.Threading.Tasks.Task[numThreads];

            var tf = new System.Threading.Tasks.TaskFactory(System.Threading.Tasks.TaskCreationOptions.LongRunning, System.Threading.Tasks.TaskContinuationOptions.None);

            for (int i = 0; i < numThreads; i++)
            {
                tasks[i] = (tf.StartNew(() => ProcessFile(buffer, chunkSize)));
            }

            System.Threading.Tasks.Task.WaitAll(tasks);
        }

        #region Pipeline Methods
        /// <summary>
        /// Create a processing pipeline and process a single file at a time.
        /// </summary>
        /// <param name="fileInputs">A thread-safe collection of file paths.</param>
        /// <param name="chunkSize">The number of lines from the file to process through the pipeline at a time.</param>
        private static void ProcessFile(System.Collections.Concurrent.BlockingCollection<string> fileInputs, int chunkSize=1)
        {
            foreach (var filePath in fileInputs.GetConsumingEnumerable())
            {
                var path = System.IO.Path.GetDirectoryName(filePath);
                var fileNameRaw = System.IO.Path.GetFileNameWithoutExtension(filePath);
                var newFilePath = System.IO.Path.Combine(path, (fileNameRaw + ".txt"));

                var buffer1 = new System.Collections.Concurrent.BlockingCollection<string>(1);
                var buffer2 = new System.Collections.Concurrent.BlockingCollection<string>();
                var buffer3 = new System.Collections.Concurrent.BlockingCollection<string>();
                var buffer4 = new System.Collections.Concurrent.BlockingCollection<string>();
                var buffer5 = new System.Collections.Concurrent.BlockingCollection<string>();
                var buffer6 = new System.Collections.Concurrent.BlockingCollection<string>();

                var f = new System.Threading.Tasks.TaskFactory(System.Threading.Tasks.TaskCreationOptions.LongRunning, System.Threading.Tasks.TaskContinuationOptions.None);

                var stage1 = f.StartNew(() => Decompress(buffer1, filePath));
                var stage2 = f.StartNew(() => Read(buffer1, buffer2, chunkSize));
                var stage3 = f.StartNew(() => Regex(buffer2, buffer3, nullRegexPattern, nullRegexReplace));
                var stage4 = f.StartNew(() => Regex(buffer3, buffer4, dateRegexPattern, dateRegexReplace));
                var stage5 = f.StartNew(() => Regex(buffer4, buffer5, trueRegexPattern, trueRegexReplace));
                var stage6 = f.StartNew(() => Regex(buffer5, buffer6, falseRegexPattern, falseRegexReplace));
                var stage7 = f.StartNew(() => Write(buffer6, newFilePath));

                System.Threading.Tasks.Task.WaitAll(stage1, stage2, stage3, stage4, stage4, stage5, stage6, stage7);
            }
        }

        /// <summary>
        /// A pipeline wrapper to extract a file to a string from a .gz archive.
        /// </summary>
        /// <param name="output">The output pipeline buffer</param>
        /// <param name="filePath">The path to the archive file</param>
        private static void Decompress(System.Collections.Concurrent.BlockingCollection<string> output, string filePath)
        {
            try
            {
                var decomp = DecompressGzToString(filePath, 1024);
                output.Add(decomp);
            }
            finally
            {
                output.CompleteAdding();
            }
        }

        /// <summary>
        /// A pipeline wrapper to read in a string and spool the file to the output buffer in chunks.
        /// </summary>
        /// <param name="inputColl">The input pipeline buffer</param>
        /// <param name="output">The output pipeline buffer</param>
        /// <param name="chunkSize">The number of lines per string to be put on the output buffer</param>
        private static void Read(System.Collections.Concurrent.BlockingCollection<string> inputColl, System.Collections.Concurrent.BlockingCollection<string> output, int chunkSize=1)
        {
            if (chunkSize == 1)
            {
                try
                {
                    foreach (var input in inputColl.GetConsumingEnumerable())
                    {
                        //do line by line
                        var ind = 0;

                        for (int i = 0; i < input.Length; i++)
                        {
                            if (input[i] == '\r')
                            {
                                output.Add(input.Substring(ind, (i + 2) - ind));
                                ind = i + 2; //we know that the \r is followed by \n
                            }
                        }

                        if (ind < input.Length)
                        {
                            output.Add(input.Substring(ind, input.Length - ind));
                        }
                    }
                }
                finally
                {
                    output.CompleteAdding();
                }
            }
            else
            {

                try
                {
                    var counter = 0;
                    var chunk = new string[chunkSize];
                    foreach (var input in inputColl.GetConsumingEnumerable())
                    {
                        //do line by line
                        var ind = 0;

                        for (int i = 0; i < input.Length; i++)
                        {
                            if (input[i] == '\r')
                            {
                                if (counter == chunkSize - 1)
                                {
                                    output.Add(input.Substring(ind, (i + 2) - ind));
                                    ind = i + 2; //we know that the \r is followed by \n
                                    counter = 0;
                                }
                                else
                                {
                                    counter++;
                                }
                            }
                        }

                        if (ind < input.Length)
                        {
                            output.Add(input.Substring(ind, input.Length - ind));
                        }
                    }
                }
                finally
                {
                    output.CompleteAdding();
                }
            }
        }

        /// <summary>
        /// A pipeline wrapper to run a regex replace on a provided string.
        /// </summary>
        /// <param name="input">The input pipeline buffer</param>
        /// <param name="output">The output pipeline buffer</param>
        /// <param name="pattern">The regex pattern to search for</param>
        /// <param name="replace">The string to replace results with</param>
        private static void Regex(System.Collections.Concurrent.BlockingCollection<string> input, System.Collections.Concurrent.BlockingCollection<string> output, string pattern, string replace)
        {
            try
            {
                foreach (var s in input.GetConsumingEnumerable())
                {
                    output.Add(RegexReplaceCompiled(s, pattern, replace));
                }
            }
            finally
            {
                output.CompleteAdding();
            }
        }

        /// <summary>
        /// A pipeline wrapper to write the input to a file
        /// </summary>
        /// <param name="input">The input pipeline buffer</param>
        /// <param name="outFilePath">The path for the file to write to</param>
        /// <param name="firstRowEmpty">Should the first row in the result be a blank line</param>
        /// <remarks>The first row may need to be empty when using the SQL Bulk Loader to accept in the information</remarks>
        private static void Write(System.Collections.Concurrent.BlockingCollection<string> input, string outFilePath, bool firstLineBlank=true)
        {
            using (var sw = new System.IO.StreamWriter(outFilePath))
            {
                sw.NewLine = "\n";

                if (firstLineBlank)
                {
                    sw.WriteLine("");
                }

                foreach (var chunk in input.GetConsumingEnumerable())
                {
                    sw.WriteLine(chunk);
                }
            }
        }
        #endregion

        #region Data Processing
        /// <summary>
        /// Extract a .gz file in to a string.
        /// </summary>
        /// <param name="filePath">The path to the .gz file</param>
        /// <param name="bufferSize">The size of the buffer between byte streams</param>
        /// <param name="firstRowEmpty">Should the first row in the result be a blank line</param>
        /// <remarks>The first row may need to be empty when using the SQL Bulk Loader to accept in the information</remarks>
        private static string DecompressGzToString(string filePath, int bufferSize=1024, bool firstRowEmpty = false)
        {
            using (var fs = System.IO.File.OpenRead(filePath))
            {
                using (var gzs = new System.IO.Compression.GZipStream(fs, System.IO.Compression.CompressionMode.Decompress))
                {
                    using (var os = new System.IO.MemoryStream())
                    {
                        var buffer = new byte[bufferSize];

                        if (firstRowEmpty)
                        {
                            var nl = "\n";
                            os.Write(System.Text.Encoding.UTF8.GetBytes(nl), 0, nl.Length);
                        }

                        while (true)
                        {
                            var read = gzs.Read(buffer, 0, bufferSize);
                            if (read <= 0) break;
                            os.Write(buffer, 0, read);
                        }

                        using (var sr = new System.IO.StreamReader(os))
                        {
                            os.Position = 0;
                            return sr.ReadToEnd();
                        }
                    }
                }
            }
        }

        /// <summary>
        /// Use a compiled, static regex method call to replace the pattern match
        /// </summary>
        /// <param name="input">The string to check</param>
        /// <param name="pattern">The pattern to match</param>
        /// <param name="replace">The replacement for any matches</param>
        /// <returns></returns>
        private static string RegexReplaceCompiled(string input, string pattern, string replace)
        {
            return System.Text.RegularExpressions.Regex.Replace(input, pattern, replace, System.Text.RegularExpressions.RegexOptions.Compiled);
        }
        #endregion
    }
}
"@

Add-Type -TypeDefinition $Source -Language CSharp
Remove-Variable Source -Force

#These functions are not used in the updates because they are slower than the C# code provided, but can be used 
#to debug or run manually

#takes in a gzip data object or file and returns the file split on new line characters
function Extract-GzData {
[CmdletBinding(DefaultParameterSetName="Data")]
    param (
        [Parameter(Position=0,
            ParameterSetName="Data",
            Mandatory=$true, 
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)]
        [byte[]]$Data,

        [Parameter(Position=0,
            ParameterSetName="File", 
            Mandatory=$true, 
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)]
        $FilePath,

        [switch]$FirstRowEmpty
    )

    $result = $null
    try {
        if ($PSCmdlet.ParameterSetName -eq "File") {

            $GzipStream = New-Object System.IO.Compression.GZipStream -ArgumentList `
                @([System.IO.File]::OpenRead($FilePath),[System.IO.Compression.CompressionMode]::Decompress)

        } else {
            $inputStream = New-Object System.IO.MemoryStream -ArgumentList @(,$Data)

            $GzipStream = New-Object System.IO.Compression.GZipStream $inputStream, ([IO.Compression.CompressionMode]::Decompress)
        }

        $outputStream = New-Object System.IO.MemoryStream

        $buffer = New-Object byte[](1024)
    
        if ($FirstRowEmpty) {
            $str = "`n"
            $NewLine = [System.Text.Encoding]::UTF8.GetBytes($str)
            $outputStream.Write($NewLine, 0, $str.Length)
        }

        while($true){
            $read = $GzipStream.Read($buffer, 0, 1024)
            if ($read -le 0){break}
            $outputStream.Write($buffer, 0, $read)
        }

        $streamReader = New-Object System.IO.StreamReader $outputStream

        $outputStream.Position = 0

        $result = $streamReader.ReadToEnd()

    } finally {
        $streamReader.Close()
        $GzipStream.Close()
        $outputStream.Close()

        if (-not $PSCmdlet.ParameterSetName -eq "File") {
            $inputStream.Close()
        }
    }

    return $result
}

#writes a chunk of data to a gz file directly
function Out-GzFile {
    param (
        [Parameter(Position=0, 
            Mandatory=$true, 
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)]
        [byte[]]$Data,

        [Parameter(Position=1)]
        $Path
    )

    try {
        $memoryStream = New-Object System.IO.MemoryStream -ArgumentList @(,$Data)
        $fileStream = New-Object System.IO.FileStream -ArgumentList @(,$Path, `
            [System.IO.FileMode]::Create,[System.IO.FileAccess]::Write)
        $memoryStream.WriteTo($fileStream)
    } finally {
        $fileStream.Close()
        $memoryStream.Close()
    }
}

#write a canvas file to disk
function Write-CanvasDataFile ($Data, $FilePath) {
    $Data | Out-File $FilePath -Force utf8
}

$rPatternNull = "(?<=(^|`n|`t))\\N(?=($|`n|`t))"
$rPatternDate = "(?<=(\d\d:\d\d:\d\d))(\.\d*)" #"(?<=(\d\d:\d\d:\d\d\.\d\d\d))(\d*)"
$rPatternTrue = "(?<=(^|`n|`t))true(?=($|`n|`t))"
$rPatternFalse = "(?<=(^|`n|`t))false(?=($|`n|`t))"

#Call a compile regex method
function Call-CompiledRegex($inputString, $pattern, $replacement){
    return ([System.Text.RegularExpressions.Regex]::Replace($inputString, $pattern, `
        $replacement, [System.Text.RegularExpressions.RegexOptions]::Compiled))
}

#Allows you to manually run the regex on a file
function Run-RegexOnFile($tableSchema, $data){
    $types = $tableSchema.columns | select -Unique -ExpandProperty type
    
    $data = Call-CompiledRegex $data $rPatternNull ""

    if ($types.Contains("timestamp")){
        $data = Call-CompiledRegex $data $rPatternDate ""
    }
    if ($types.Contains("boolean")){
        $data = Call-CompiledRegex $data $rPatternTrue "1"
        $data = Call-CompiledRegex $data $rPatternFalse "0"
    }

    return $data
}

#endregion

#region Canvas Api Helpers

#Retrieves the data from a given URL (results are compressed)
function Get-CanvasFileDataFromUrl ($Url) {
    $data = (New-Object System.Net.WebClient).DownloadData($Url)

    return $data
}

#update a schema object with a list of the subobjects and a dictionary of the table name and schema
function Set-CanvasSchemaDetails ($Schema) {
    $TableSchemas = @{}

    #Collect the schemas by table name
    $SchemaObjects = $Schema.schema | gm -MemberType NoteProperty | select -ExpandProperty name

    foreach ($SubObject in $SchemaObjects) {
        $s = $Schema.schema.($SubObject)
        $TableSchemas[$s.tableName] = $S
    }

    $Schema | Add-Member -MemberType NoteProperty "objectNames" $SchemaObjects
    $Schema | Add-Member -MemberType NoteProperty "tablesSchemaDict" $TableSchemas
}

#Add a range of data to a fileInfo object
function Add-FilePaths ($FileInfo, $DestDir, $ServerLocalDir) {
    $fileName = $FileInfo.filename -replace ".gz",""
    $FileInfo | Add-Member -MemberType NoteProperty "zipPath" `
        ([System.IO.Path]::Combine($DestDir, $fileInfo.fileName))
    $FileInfo | Add-Member -MemberType NoteProperty "extractedPath" `
        ([System.IO.Path]::Combine($DestDir, ($fileName + ".txt")))
    $FileInfo | Add-Member -MemberType NoteProperty "serverLocalPath" `
        ([System.IO.Path]::Combine($ServerLocalDir, ($fileName + ".txt")))
    $FileInfo | Add-Member -MemberType NoteProperty "formatFilePath" `
        ([System.IO.Path]::Combine($DestDir, ($fileInfo.table + ".xml")))
    $FileInfo | Add-Member -MemberType NoteProperty "formatFileLocalPath" `
        ([System.IO.Path]::Combine($ServerLocalDir, ($fileInfo.table + ".xml")))
    $FileInfo.filename = $fileName

    return $FileInfo
}

#return a formatted schema updated with the URLs for each table from a full sync endpoint
function Get-FilesSchemaFromSync ($DestPath, $ServerLocalPath) {
    $sync = Get-CanvasDataSync

    $expiringUrls = Get-CanvasDataExpiringUrls

    $schema = Get-CanvasDataSchema -Version $sync.schemaVersion

    $schema | Add-Member -MemberType NoteProperty "sequence" $expiringUrls.sequence

    $schema | Add-Member -MemberType NoteProperty "files" (New-Object System.Collections.ArrayList)

    Set-CanvasSchemaDetails $schema
            
    foreach ($file in $sync.files) {

        $table = $schema.TablesSchemaDict[$file.table]

        $file = Add-FilePaths $file $DestPath $ServerLocalPath
        
        $file | Add-Member -MemberType NoteProperty "tableSchema" $table

        if ($table.files -eq $null) {
            $table | Add-Member -MemberType NoteProperty "files" (New-Object System.Collections.ArrayList)
        }

        $table.files.Add($file) | Out-Null
        $schema.files.Add($file) | Out-Null
    }

    return $schema
}

#return a formatted schema updated with the URLs for each table from the latest expiring url endpoint
function Get-FilesSchemaFromExpiring ($DestPath, $ServerLocalPath) {
    $expiringUrls = Get-CanvasDataExpiringUrls

    $schema = Get-CanvasDataSchema -Version $expiringUrls.schemaVersion

    Set-CanvasSchemaDetails $schema

    $schema | Add-Member -MemberType NoteProperty "sequence" $expiringUrls.sequence

    $schema | Add-Member -MemberType NoteProperty "files" (New-Object System.Collections.ArrayList)
        
    $artifactNames = $expiringUrls.artifactsByTable | gm -MemberType NoteProperty | select -ExpandProperty name

    foreach ($aName in $artifactNames) {
        $a = $expiringUrls.artifactsByTable.($aName)

        $table = $schema.TablesSchemaDict[$a.tableName]

        foreach ($file in $a.files) {
            $file | Add-Member -MemberType NoteProperty "table" $a.tableName
            $file | Add-Member -MemberType NoteProperty "partial" $a.partial
            $file | Add-Member -MemberType NoteProperty "tableSchema" $table
            $file = Add-FilePaths $file $DestPath $ServerLocalPath
        }

        if ($table.files -eq $null) {
            $table | Add-Member -MemberType NoteProperty "files" (New-Object System.Collections.ArrayList)
        }

        $table.files.AddRange($a.files)
        $schema.files.AddRange($a.files)
    }

    return $schema
}

#endregion

#take in a formatted schema and download all files referenced
function Download-CanvasDbFiles ($Schema, $WriteProgress=$false, 
    [switch]$InParallel, $ParallelMax = 8){
    
    if ($WriteProgress) {
        $filesProcessed = 0
        $fileCount = $schema.files.Count
    }

    if ($InParallel) {

        $jobname = "canvasDl"

        foreach ($fileinfo in $schema.files) {

            $running = Get-Job | where {$_.Name -eq $jobname -and $_.State -eq "Running"}

            if ($running.Count -ge $ParallelMax) {
                $running | Wait-Job -Any | Out-Null
            }
            
            $url = $fileInfo.url
            $path = $fileInfo.zipPath

            Start-Job {
                (New-Object System.Net.WebClient).DownloadFile($using:Url,$using:path)
            } -Name $jobname | Out-Null
        }

        get-job | where Name -like "*$jobname*" | Wait-Job | Remove-Job

    } else {
        foreach ($fileInfo in $schema.files) {

            if ($WriteProgress) {Write-Progress -Activity ("Downloading file {0}" -f $fileInfo.filename) `
                -PercentComplete (($filesProcessed / $fileCount)*100) }

            (New-Object System.Net.WebClient).DownloadFile($fileInfo.url,$fileInfo.zipPath)

            if ($WriteProgress) {Write-Progress -Activity ("Downloading file {0}" -f $fileInfo.filename) `
                -Completed}

            if ($WriteProgress) { $filesProcessed++ }
        }
    }
}

#Extracting use:
#[CanvasData.Utils]::RunFilesAsThreads($DestinationPath)