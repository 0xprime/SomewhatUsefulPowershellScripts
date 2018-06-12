param 
(
    # Path to folder containing your projects, defaults to one level above script location.
    [string]$path = ((Resolve-Path ..\).path),
    #Command to run, defaults to pull.
    [string]$command = "pull"
)

$folders = Get-ChildItem -Directory $path

Write-Host "> Running `"git $command`" for projects in folder $path"

foreach ($folder in $folders) 
{
    Write-Host "> Git $command`: $folder"
    Set-Location ($path + "\" + $folder.Name)
    git $command
}