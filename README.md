# SomewhatUsefulPowershellScripts
A collection of small Powershell scripts that may be handy.

## PortScanner
A simple and inefficient port scanner.

Example:
`.\PortScanner.ps1 -servers 10.0.0.1,10.0.0.2 -ports 21,22,23 -timeout 500`

## MassGitPull
Runs `git pull` in all project folders. 

Example: 
`.\MassGitPull.ps1 -path C:\Github`