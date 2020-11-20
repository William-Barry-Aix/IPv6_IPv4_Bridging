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
    - ipaddr: 172.16.2.132
    - netmask: 28

eth2:
  network.managed:
    - enabled: True
    - type: eth
    - proto: none
    - ipaddr: 172.16.2.162
    - netmask: 28

# enable ipv4 forwarding
net.ipv4.ip_forward:
  sysctl:
    - present
    - value: 1

routes:
  network.routes:
    ## Bizare, mais marche !!! Le truc bug, c'est pas ma faute
    ## Il semblerais que la première route ne s'ajoute jamais
    - name: eth1
    - routes:
      - name: LAN3-6
        ipv6addr: fc00:1234:3::/64
        gateway: fc00:1234:1::131
    - name: eth2
    - routes:
      - name: LAN4-6
        ipv6addr: fc00:1234:4::/64
        gateway: 172.16.2.163
    - name: eth1
    - routes:
      - name: LAN3-6
        ipv6addr: fc00:1234:3::/64
        gateway: fc00:1234:1::131
