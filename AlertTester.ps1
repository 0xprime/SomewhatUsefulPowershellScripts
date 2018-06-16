# This still in testing. 

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
    $webhook
)

$alertSubject = "Alert test"
$alertBody = "This is an alert test."

switch ($alert){
    smtp {
        if ((!$smtpFrom) -and (!$smtpTo) -and (!$smtpServer)) { Write-Warning "> Cannot send email, requires smtpTo, smtpFrom and smtpServer."; break}
        
        # $credentials = $null
        Write-Verbose "> Sending Email alert to $smtpTo from $smtpFrom through $smtpServer." 
        Send-Mailmessage -to $smtpTo -from $smtpFrom -subject $alertSubject -BodyAsHtml $alertBody -smtpserver $smtpServer #-Credential $credentials
    }
    teams {
        # Requires Teams Webhook Connector.
        if (!$webhook) {Write-Warning "> Cannot send alert, requires Webhook."; break}
        $body = @{
            'text'= "<p>" + $alertSubject + "</p><p>" + $alertBody + "</p>"
        }
        $request = @{
            Headers = @{'accept'='application/json'}
            Body = $Body | convertto-json
            Method = 'POST'
            URI = $webhook 
        }
        Invoke-RestMethod @request
    }
    slack {
        # Todo
        if (!$webhook) {Write-Warning "> Cannot send alert, requires Webhook."; break}
        $body = @{
            'text'= $alertBody
            'pretext' = $alertSubject
            'color' = "warning"
        }
        $request = @{
            Headers = @{'accept'='application/json'}
            Body = $Body | convertto-json
            Method = 'POST'
            URI = $webhook 
        }
        Invoke-RestMethod @request
    }
}
