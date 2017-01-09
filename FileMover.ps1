<#
.Synopsis
   FileOrganiser moves files according to their last modified date
.DESCRIPTION
   This script will list all files in a directory and move them into a sub dirctory according to their
   last modified date.
.EXAMPLE
   .\FileMover.ps1 -BaseDirectory c:\photos\
#>
Param
(
    # BaseDirectory is the directory in which this script should operate
    [Parameter(Mandatory=$true,
                ValueFromPipelineByPropertyName=$true,
                Position=0)]
    $BaseDirectory
)



cd $BaseDirectory

$files = Get-ChildItem -File

foreach ($file in $files)
{
    $year = $file.LastWriteTime.Year
    $month = $file.LastWriteTime.Month
    $day = $file.LastWriteTime.Day
    $name = $file.BaseName
    
    $destination = "$BaseDirectory\$year\$month\$day"

    if (Test-Path $destination)
    {
        Write-Host "Moving $name to $destination."
        Move-Item $file $destination
    }
    else
    {
        Write-Host "Need to create $destination"
        if(New-Item $destination -ItemType Directory)
        {
            Write-Host "Moving $name to $destination"
            Move-Item $file $destination
        }
    }
}