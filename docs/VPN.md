
# Configure machine to connect to

In this case this is Ubuntu 18.10

`ssh target`

`sudo vim /etc/NetworkManager/system-connections/VPN.nmconnection`
```
[connection]
id=Marciso VPN
uuid=1ce6a503-0085-46e5-91fc-640ed4f4bf00
type=vpn
autoconnect=false
permissions=
timestamp=

[vpn]
gateway=$vpn_server  # VPN server name, can be behind a router, but ports have to be forwarded (see below)
ipsec-enabled=yes
#ipsec-esp=aes128-sha1!  # weak crypto
#ipsec-ike=aes128-sha1-modp1024!  # weak crypto
ipsec-psk=$vpn_secret  # this needs to match to the server secret
mru=1500
mtu=1500
password-flags=1
refuse-chap=yes
refuse-eap=yes
refuse-pap=yes
#require-mppe-40=yes  # weak crypto
user=$vpn_user  ## set it to the VPN user / L2TP
service-type=org.freedesktop.NetworkManager.l2tp

[ipv4]
dns=10.43.22.56;10.31.104.16;  # set the DNSses to the current value of your netwrok
dns-search=example.net;  # setting of the current network
method=auto
route-metric=800  ## important: increase the routing metric so it is considered last

[ipv6]
addr-gen-mode=stable-privacy
dns-search=
ip6-privacy=0
method=auto

[proxy]
```

# Configure port forwarding on the router

Name | Port | Protocol | Comment
-----|------|----------|----
L2TP | 1701 | UDP
IPSec NAT-T | 4500 | UDP | NAT-T does not have to be used, 
IPSec IKE | 500 | UDP
~~IPSec ESP~~ | ~~50~~ | ~~IP (UDP)~~ | IP port, should be forwarded by the router automatically
~~IPSec ISAKMP~~ | ~~51~~ | ~~IP (UDP)~~ | IP port, should be forwarded by the router automatically
PPTP | 1723 | TCP
~~PPTP~~ | ~~47~~ | ~~IP (UDP)~~ | IP port, should be forwarded by the router automatically

* For OpenVPN, we allow connections via TCP or UDP protocols on ports 443 or 1194. The IPVanish software uses port 443
* Both PPTP and L2TP need the PPTP & L2TP pass-through options in the firewall/router's management interface to be enabled (if applicable). Routers without these options may not support PPTP or L2TP traffic
    * To allow PPTP traffic, open TCP port 1723
    * To allow L2TP w/ IPSec traffic, open UDP ports 500, 1701 & 4500
* Both IPSec and IKEv2 use UDP port 500
* SSTP uses TCP port 443 (MS-SSTP, Microsoft Secure Socket Tunneling Protocol, is a VPN protocol which is developed by Microsoft Corporation. It implements PPP over HTTPS (SSL). It capsules all user packets on TCP. So it can pass the firewall easily. The bandwidth of SSTP is not so fast. The advantage of SSTP is; Windows Vista and later OS has a built-in SSTP VPN client, and configuration of SSTP is very easy.)

## Limitations of IPsec VPN
Noted that there are some limitations of IPsec VPN pass-through due to the incompatibilities between IPsec and NAT:
 * IPsec with Authentication Header (AH) cannot pass through NAT because AH does not allow changing the IP header
 * To pass through multiple outgoing IPsec tunnels, it requires that both the VPN client and server support NAT-Traversal (NAT-T). Without NAT-T, it only allows one outgoing IPsec VPN at the same time.
 * L2TP with IPsec policy is in transport mode, which can only pass through NAT if both VPN client and server support NAT-T (Note: All Vigor Router support NAT-T).

# Restart services on the target
`systemctl restart NetworkManager`
* observe for any errors in /var/log/syslog
* network manager /has/ to be restarted

`nmtui-connect` 
- select your connection and activate

# Permisions
When you log in with SSH, NetworkManager does not allow you to change network permissions

1. Add user to `netdev` group
   1. `sudo usermod -G netdev -a $USER`
   1. Re-login
1. Change polkit permissions
   1. `sudo vim /etc/polkit-1/localauthority/50-local.d/allow-ssh-networking.pkla`
      ```
      [Let adm group modify system settings for network]
      Identity=unix-group:adm
      Action=org.freedesktop.NetworkManager.network-control
      ResultAny=yes
      ```
   1. restart polkit
   `sudo systemctl restart polkit.service`

# Autoconnect
```
[connection]
autoconnect=true

[vpn]
password-flags=0  # 0 = do not ask for password

[vpn-secrets]
password=$user_password
```
# Verify

```
$ ifconfig
ppp0: flags=4305<UP,POINTOPOINT,RUNNING,NOARP,MULTICAST>  mtu 1400
        inet 10.2.0.2  netmask 255.255.255.255  destination 10.2.0.1
        ppp  txqueuelen 3  (Point-to-Point Protocol)
        RX packets 353  bytes 25485 (24.8 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 319  bytes 154172 (150.5 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
$ route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
default         _gateway        0.0.0.0         UG    100    0        0 enp6s0
default         _gateway        0.0.0.0         UG    600    0        0 wlxd0374535bd1b
default         0.0.0.0         0.0.0.0         U     800    0        0 ppp0
10.2.0.1        0.0.0.0         255.255.255.255 UH    800    0        0 ppp0
10.3.0.0        0.0.0.0         255.255.0.0     U     600    0        0 wlxd0374535bd1b
10.31.110.0     0.0.0.0         255.255.255.0   U     100    0        0 enp6s0
_gateway        0.0.0.0         255.255.255.255 UH    100    0        0 enp6s0
cpc86635-seve26 _gateway        255.255.255.255 UGH   100    0        0 enp6s0
link-local      0.0.0.0         255.255.0.0     U     1000   0        0 enp6s0

$ resolvectl
Link 7 (ppp0)
      Current Scopes: DNS
DefaultRoute setting: yes
       LLMNR setting: yes
MulticastDNS setting: no
  DNSOverTLS setting: no
      DNSSEC setting: no
    DNSSEC supported: no
  Current DNS Server: 10.31.104.16
         DNS Servers: 10.0.0.129
                      10.43.22.56
                      10.31.104.16
          DNS Domain: ~.
                      example.net
```
