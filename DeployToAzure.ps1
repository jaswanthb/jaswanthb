Install-Module -Name ReportingServicesTools -Force -Verbose #Force powershell to install
Import-Module -Name ReportingServicesTools #-Verbose

$reportServerUri = "$(ReportServerUrl)" #Set in variables 
$path = "$(System.DefaultWorkingDirectory)/{Change-to-artifactory-name}/ssrs-$(Build.BuildId)/working"
$env = "$(Environment)"#Set in variables 
$folder = "/"

echo $reportServerUri
echo $path
echo $env

if($env -ne "PROD")
{
    #If not prod its lower env, deploy to test reports folder
    $folder = "/TestReports/"
    New-RsFolder -ReportServerUri $reportServerUri -Path "/" -Name TestReports -Verbose -ErrorAction SilentlyContinue
}

$folderNames = Get-ChildItem -Path $path | where {!$_.DirectoryName}| Select-Object Name

#Create folder in Reporting server
foreach($f in $folderNames)
{
    New-RsFolder -ReportServerUri $reportServerUri -Path $folder -Name $f.Name -Verbose -ErrorAction SilentlyContinue
}

#upload reports to report server
$folders = new-object collections.generic.list[object]
$folders = get-childitem $path -rec -Include *.rdl | where {!$_.PSIsContainer} | select-object FullName

foreach($f in $folders)
{
    $destination =  $f.FullName.Replace($path,"").split("\")[0]

    Write-RsCatalogItem -ReportServerUri $reportServerUri -Path $f.FullName -Destination "$folder$destination" -OverWrite -Verbose
}

#Set Data source
#Thinking
