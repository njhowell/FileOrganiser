$dir = 'C:\testing\photos1'

cd $dir

$files = Get-ChildItem -File

foreach ($file in $files)
{
    $year = $file.LastWriteTime.Year
    $month = $file.LastWriteTime.Month
    $day = $file.LastWriteTime.Day
    $name = $file.BaseName
    
    $destination = "$dir\$year\$month\$day"

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