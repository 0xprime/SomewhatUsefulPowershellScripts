# Somewhat Useful Powershell Scripts
A collection of small Powershell scripts that may be handy.

## Alert Tester
A script that tests various methods to send alerts or notifications to various channels. Currently supports SMTP, Teams and Slack. Can do multiple alerts at the same time.

Todo:
- Hipchat
- ~~Stride~~
- IRC

Ideas more channels welcome. 

Example:

`.\AlertTester.ps1 -alert teams -teamsWebhook <your webhook>`

`.\AlertTester.ps1 -alert smtp -smtpTo ridley@nostromo.com -smtpFrom bishop@weyland-yutani.com -smtpServer smtp.weyland-yutani.com`

## GetExternalIP
Retrieves your external IP and some related public information. 

Example:

`.\GetExternalIP.ps1`

## PortScanner
A simple and inefficient port scanner.

Example:

`.\PortScanner.ps1 -servers 10.0.0.1,10.0.0.2 -ports 21,22,23 -timeout 500`

## MassGitPull
Runs `git pull` in all project folders. 

Example: 

`.\MassGitPull.ps1 -path C:\Github`

## MassGitCommand
Like MassGitPull, but runs a specified git command in all project folders. 

Example:

`.\MassGitCommand.ps1 -path C:\Github -command status` 