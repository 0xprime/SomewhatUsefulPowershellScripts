param 
(
    # Path to folder containing your projects, defaults to one level above script location.
    [string]$path = (Resolve-Path ..\).path
)

$folders = Get-ChildItem -Directory $path

Write-Host "> Git pulling projects in folder $path"

foreach ($folder in $folders) 
{
    Write-Host "> Git Pulling project $folder"
    Set-Location ($path + "\" + $folder.Name)
    git pull
}