# This still in testing. 

Param(
    # (Parameter help description)
    [Parameter(Mandatory=$true, Position=0)]
    [ValidateSet("smtp","teams","slack")]
    [String[]]
    $alert,
    # (Parameter help description)
#    [Parameter(Position=0)]
    [String]
    $smtpFrom,
    # (Parameter help description)
#    [Parameter(Position=0)]
    [String]
    $smtpTo,
    # Parameter help description
#    [Parameter(AttributeValues)]
    [String]
    $smtpServer,
    [String]
    $webhook
)

$alertSubject = "Alert test"
$alertBody = "<h1>This is an alert test.</h1>"

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
    }
}
