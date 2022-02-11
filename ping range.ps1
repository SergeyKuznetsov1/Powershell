$ping = New-Object System.Net.Networkinformation.Ping
100..254 | % { $ping.send(“192.168.11.$_”) | select address, status } 