# Canvas APIs for PowerShell

## About
This project is an approach to create a comprehensive, generated PowerShell client for the [(Instructure) Canvas LMS REST APIs](https://canvas.instructure.com/doc/api/) (standard, and data) for PowerShell. Use at your own risk, or contribute to the project and make it better!

#### Is the Canvas API included?
No. You'll have to generate it yourself for now.

## How To Use
Clone this repository. Open the CanvasApiGenerator.ps1 file, and call Generate-CanvasApi. This Cmdlet will return the generated document so you can do with it whatever you'd like, for instance:

```
$Generated = Generate-CanvasApi
$Generated | Out-File ".\PoshCanvas.ps1"
#or
$Generated | Set-Clipboard
```

Then run one of the methods, and it *should* work. If not, this is open source. Let me know or fix it yourself :)

## What are the files here?

##### Canvas API Generator
This script aims to automate the creation of the bulk parts of the general Canvas API Client for PowerShell, by parsing the [Swagger JSON files](https://canvas.instructure.com/doc/api/api-docs.json) provided by Instructure that document their API and converting the data in to PowerShell cmdlets.

At the time of writing, the result should be considered 'usable'.

##### Canvas API Main
This script contains the primary authentication bits and API calls for the main Canvas API. This will be combined in to the generated document.

##### Canvas Data API
This script contains wrappers for the Canvas Data API and some companion functions that can be used to ease the burden of working with the Canvas Data APIs.

Good luck, and enjoy!

## Notes about uploading files
Apparently to upload files for things like the SIS import you may need to handle the uploading outside of the generic methods provided by PowerShell; this is to allow the uploading of both params and files for a multipart/form-data request. For an example on how to handle this, please see a manually corrected version of Post-CanvasSisImports in this [Gist for Post-CanvasSisImports](https://gist.github.com/squid808/4cf31d1419a0a4771bb271eb6a32366a). Again, please note that this kind of method handling would be needed for any functions wherein you are uploading files, though I have not tested any others.

If you only need to upload a file with no params, you can simply use Invoke-Webrequest with the -InFile param.
