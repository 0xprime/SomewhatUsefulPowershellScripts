param 
(
    [string[]]$servers,
    [string[]]$ports,
    [int]$timeout = 500
)

foreach ($server in $servers) {
    foreach ($port in $ports) {
        $request = New-Object System.Net.Sockets.TcpClient
        $null = $request.BeginConnect($server, $port, $null, $null)
        Start-Sleep -milli $timeout
        if ($request.Connected) { 
            $open = $true 
        } 
        else { 
            $open = $false 
        }
        $request.Close()

        [PSCustomObject]@{
            IP   = $server
            Port = $port
            Open = $open
        }
    }
}