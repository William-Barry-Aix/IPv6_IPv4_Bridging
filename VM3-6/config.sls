## Désactivation de network-manager
NetworkManager:
  service:
    - dead
    - enable: False

##Configuration de VM1
eth1:
  network.managed:
    - enabled: True
    - type: eth
    - proto: none
    - enable_ipv4: false
    - ipv6proto: static
    - enable_ipv6: true
    - ipv6_autoconf: no
    - ipv6ipaddr: fc00:1234:2::36
    - ipv6netmask: 64 
    - ipv6gateway: fc00:1234:2::26

eth2:
  network.managed:
    - enabled: True
    - type: eth
    - proto: none
    - enable_ipv4: false
    - ipv6proto: static
    - enable_ipv6: true
    - ipv6_autoconf: no
    - ipv6ipaddr: fc00:1234:4::36
    - ipv6netmask: 64

routes:
  network.routes:
    - name: eth1
    - routes:
      - name: LAN1-6
        ipaddr: fc00:1234:1::/64
        gateway: fc00:1234:2::26
      - name: LAN3-6
        ipaddr: fc00:1234:3::/64
        gateway: fc00:1234:2::26

sudo sysctl -w net.ipv6.conf.all.forwarding=1:
  cmd:
    - run

## Configuration pour serveur echo	
dhclient eth0:
 cmd:
    - run

inetutils-inetd:
  pkg:
    - installed

update-inetd --add "echo stream tcp6 nowait nobody internal":
 cmd:
    - run

service inetutils-inetd start:
 cmd:
    - run

service inetutils-inetd restart:
 cmd:
    - run
