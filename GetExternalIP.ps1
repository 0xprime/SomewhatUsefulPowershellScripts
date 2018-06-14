# Source: https://gallery.technet.microsoft.com/scriptcenter/Get-ExternalPublic-IP-c1b601bb
$externalInfo = Invoke-RestMethod http://ipinfo.io/json 
Write-Host External IP: `t`t $externalInfo.ip -f Green
Write-Host GeoIP Country: `t`t $externalInfo.country 
Write-Host GeoIP Location: `t $externalInfo.loc 
Write-Host ISP: `t`t`t $externalInfo.org