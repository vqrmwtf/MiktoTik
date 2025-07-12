# jul/12/2025 12:43:16 by RouterOS 6.49.19
# software id = 
#
#
#
/interface ethernet
set [ find default-name=ether2 ] name=LAN
set [ find default-name=ether3 ] name=MGMT
set [ find default-name=ether1 ] name=WAN
/interface vlan
add interface=LAN name=VLAN-10-MGMT vlan-id=10
add interface=LAN name=VLAN-20-STAFF vlan-id=20
add interface=LAN name=VLAN-30-GUEST vlan-id=30
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=DHCP-POOL-MGMT ranges=192.168.10.50-192.168.10.100
add name=DHCP-POOL-STAFF ranges=192.168.20.50-192.168.20.150
add name=DHCP-POOL-GUEST ranges=192.168.30.50-192.168.30.200
/ip dhcp-server
add address-pool=DHCP-POOL-MGMT disabled=no interface=VLAN-10-MGMT name=\
    DHCP-MGMT
add address-pool=DHCP-POOL-STAFF disabled=no interface=VLAN-20-STAFF name=\
    DHCP-STAFF
add address-pool=DHCP-POOL-GUEST disabled=no interface=VLAN-30-GUEST name=\
    DHCP-GUEST
/queue simple
add max-limit=50M/50M name=Staff-Bandwidth target=192.168.20.0/24
add max-limit=10M/10M name=Guest-Bandwidth target=VLAN-30-GUEST
add max-limit=2M/2M name=Guest-Per-User target=192.168.30.0/24
/interface bridge port
add interface=LAN
add interface=VLAN-10-MGMT
add interface=VLAN-20-STAFF
add interface=VLAN-30-GUEST
/interface bridge vlan
add tagged=LAN vlan-ids=10
add tagged=LAN vlan-ids=20
add tagged=LAN vlan-ids=30
/ip address
add address=192.168.32.1/24 interface=MGMT network=192.168.32.0
add address=192.168.10.1/24 interface=VLAN-10-MGMT network=192.168.10.0
add address=192.168.20.1/24 interface=VLAN-20-STAFF network=192.168.20.0
add address=192.168.30.1/24 interface=VLAN-30-GUEST network=192.168.30.0
/ip dhcp-client
add disabled=no interface=WAN
/ip dhcp-server network
add address=192.168.10.0/24 dns-server=8.8.8.8,1.1.1.1 gateway=192.168.10.1
add address=192.168.20.0/24 dns-server=8.8.8.8,1.1.1.1 gateway=192.168.20.1
add address=192.168.30.0/24 dns-server=8.8.8.8,1.1.1.1 gateway=192.168.30.1
/ip dns
set allow-remote-requests=yes servers=8.8.8.8,1.1.1.1
/ip dns static
add address=192.168.10.1 name=router.local
add address=192.168.10.10 name=fileserver.local
/ip firewall filter
add action=accept chain=forward connection-state=established,related
add action=accept chain=forward protocol=icmp
add action=accept chain=forward src-address=192.168.10.0/24
add action=accept chain=forward dst-address=!192.168.0.0/16 src-address=\
    192.168.20.0/24
add action=accept chain=forward dst-address=!192.168.0.0/16 src-address=\
    192.168.30.0/24
add action=drop chain=forward
add action=accept chain=input connection-state=established,related
add action=accept chain=input protocol=icmp
add action=accept chain=input src-address=192.168.10.0/24
add action=accept chain=input dst-port=67,68 protocol=udp
add action=accept chain=input dst-port=53 protocol=udp
add action=accept chain=input dst-port=53 protocol=tcp
add action=drop chain=input
/ip firewall nat
add action=masquerade chain=srcnat out-interface=WAN
add action=dst-nat chain=dstnat dst-port=8080 in-interface=WAN protocol=tcp \
    to-addresses=192.168.10.10 to-ports=80
/system identity
set name=MikroTik-Office
/system logging
add topics=info,error,warning,critical
add topics=firewall
/tool graphing interface
add interface=WAN
add interface=VLAN-10-MGMT
add interface=VLAN-20-STAFF
add interface=VLAN-30-GUEST
/tool graphing resource
add
