
# connecting to localhost:22 will forward to WSL service
netsh interface portproxy add v4tov4 listenaddress=0.0.0.0 listenport=22 connectaddress=localhost connectport=22

netsh interface portproxy show all

netsh advfirewall firewall add rule name="Open SSH (to WSL)" dir=in action=allow protocol=TCP localport=22

wsl service ssh status
# wsl service ssh start
