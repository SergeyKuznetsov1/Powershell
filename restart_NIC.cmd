netsh interface set interface name="Ethernet" admin=DISABLED

ping 127.0.0.1 -n 6 > nul

netsh interface set interface name="Ethernet" admin=ENABLED
