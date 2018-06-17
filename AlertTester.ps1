Param(
    [Parameter(Mandatory=$true, Position=0)]
    [ValidateSet("smtp","teams","slack")]
    [String[]]
    $alert,
    [String]
    $smtpFrom,
    [String]
    $smtpTo,
    [String]
    $smtpServer,
    [String]
    $slackWebhook,
    [String]
    $teamsWebhook
)

$alertSubject = "Alert test"
$alertBody = "This is an alert test."

switch ($alert){
    smtp {
        if ((!$smtpFrom) -and (!$smtpTo) -and (!$smtpServer)) { 
            Write-Warning "> Cannot send email, requires smtpTo, smtpFrom and smtpServer."
            break 
        }
        
        # $credentials = $null
        Write-Verbose "> Sending Email alert to $smtpTo from $smtpFrom through $smtpServer." 
        Send-Mailmessage -to $smtpTo -from $smtpFrom -subject $alertSubject -BodyAsHtml $alertBody -smtpserver $smtpServer #-Credential $credentials
    }
    teams {
        # Requires Teams Webhook.
        if (!$teamsWebhook) {
            Write-Warning "> Cannot send alert, requires Webhook."
            break
        }
        Write-Verbose "> Sending alert to Teams channel."
        $data = @{
            'text'= "<p>" + $alertSubject + "</p><p>" + $alertBody + "</p>"
        }
        $request = @{
            Headers = @{'accept'='application/json'}
            Body = $data | ConvertTo-JSON
            Method = 'POST'
            URI = $teamsWebhook 
        }
        Invoke-RestMethod @request
    }
    slack {
        # Requires Slack webhook.
        if (!$slackWebhook) { 
            Write-Warning "> Cannot send alert, requires Webhook."
            break 
        }
        Write-Verbose "> Sending alert to Slack channel."
        $data = @{
            'text'= $alertBody
            'pretext' = $alertSubject
            'color' = "warning"
        }
        $request = @{
            Headers = @{'accept'='application/json'}
            Body = $data | ConvertTo-JSON
            Method = 'POST'
            URI = $slackWebhook 
        }
        Invoke-RestMethod @request
    }
}
