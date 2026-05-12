# Simple test client
try {
    $client = New-Object System.Net.Sockets.TcpClient
    $client.Connect("192.168.0.11", 17178) # Use the correct IP
    Write-Host "Connection successful!" -ForegroundColor Green
    
    $stream = $client.GetStream()
    $writer = New-Object System.IO.StreamWriter($stream)
    $reader = New-Object System.IO.StreamReader($stream)
    
    # Send a simple command
    $writer.WriteLine("hostname")
    $writer.Flush()
    
    # Read the response
    $response = $reader.ReadLine()
    Write-Host "Server responded: $response"
    
    $client.Close()
}
catch {
    Write-Host "Connection failed: $($_.Exception.Message)" -ForegroundColor Red
}
