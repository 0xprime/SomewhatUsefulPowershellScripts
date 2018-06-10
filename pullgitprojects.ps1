param 
(
    # Path to folder containing your projects 
    [string]$path = (Resolve-Path ..\).path
)
$folders = Get-ChildItem -Directory $path

Write-Host "> Git pulling projects in folder $path"

foreach ($folder in $folders) 
{
    Write-Host "> Git Pulling project $folder"
    Set-Location ($path + "\" + $folder.Name)
    git pull
    #Set-Location ..
} 