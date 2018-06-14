# This still in testing. 

Param(
    # (Parameter help description)
    [Parameter(Mandatory=$true, Position=0)]
    [ValidateSet("smtp","teams")]
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
    $smtpServer
)

$alertSubject = "Alert test"
$alertBody = "<h1>This is an alert test.</h1>"

switch ($alert){
    smtp {
        Write-Host "> Sending Email alert to $smtpTo from $smtpFrom through $smtpServer." 
        Send-Mailmessage -to $smtpTo -from $smtpFrom -subject $alertSubject -BodyAsHtml $alertBody -smtpserver $smtpServer
    }
    teams {
        #TODO teams 
    }
}
