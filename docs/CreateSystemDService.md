
# Code

`/etc/fix-routing`

```
#!/bin/bash

ip route add default via 10.31.110.1 dev enp6s0 || ip route replace default via 10.31.110.1 dev enp6s0


while : ; do
	( ip route | grep 'default dev enp6s0 scope link' ) && (ip route replace default via 10.31.110.1 dev enp6s0 ; echo "new table:" ; ip route)
	sleep 3
done

```

```
chmod a+x /etc/fix-routing
```

# Service configs

`/lib/systemd/system/fix-routing.service`
```
[Unit]
Description=Set default routing
After=NetworkManager.service syslog.target network.target

[Service]
Type=simple
#Restart=always
#RestartSec=1
ExecStart=/bin/bash /etc/fix-routing

[Install]
WantedBy=multi-user.target
```                             

```
sudo cp /lib/systemd/system/fix-routing.service  /etc/systemd/system/
sudo chmod 644 /etc/systemd/system/fix-routing.service
```

# Start & enable

```
sudo systemctl start fix-routing 
sudo systemctl status fix-routing

sudo systemctl restart fix-routing

sudo systemctl enable fix-routing  # for the next boot

```

# References
- https://www.linode.com/docs/quick-answers/linux/start-service-at-boot/
- https://medium.com/@benmorel/creating-a-linux-service-with-systemd-611b5c8b91d6
