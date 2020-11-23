# Configuration eth1
# RAPPEL: eth0 est à vagrant, ne pas y toucher

## Désactivation de network-manager
NetworkManager:
  service:
    - dead
    - enable: False
    
## Suppression de la passerelle par défaut
ip route del default:
  cmd:
    - run

##Configuration de VM1
eth1:
  network.managed:
    - enabled: True
    - type: eth
    - proto: none
    - ipaddr: 172.16.2.131
    - netmask: 28

eth2:
  network.managed:
    - enabled: True
    - type: eth
    - proto: none
    - enable_ipv4: false
    - ipv6proto: static
    - enable_ipv6: true
    - ipv6_autoconf: no
    - ipv6ipaddr: fc00:1234:3::1/64
    - ipv6gateway: fc00:1234:3::16
        
## Configuration de la route vers LAN1 via VM2
routes:
  network.routes:
    - name: eth1
    - routes:
      - name: LAN1
        ipaddr: 172.16.2.160/28
        gateway: 172.16.2.132
    - name: eth2
    - routes:
      - name: LAN1-6
        ipaddr: fc00:1234:1::/64
        gateway: fc00:1234:3::16
      - name: LAN2-6
        ipaddr: fc00:1234:2::/64
        gateway: fc00:1234:3::16
      - name: LAN3-6
        ipaddr: fc00:1234:3::/64
        gateway: fc00:1234:3::16
    - name: eth1
    - routes:
      - name: LAN1
        ipaddr: 172.16.2.160/28
        gateway: 172.16.2.132

net.ipv4.ip_forward:
  sysctl:
    - present
    - value: 1
    
sudo sysctl -w net.ipv6.conf.all.forwarding=1:
  cmd:
    - run

