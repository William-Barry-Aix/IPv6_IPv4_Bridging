#!/bin/bash
# configure-tun.sh

ip -6 addr add fc00:1234:ffff::1/64 dev tun0
ip -6 link set tun0 up
sysctl -w net.ipv6.conf.all.forwarding=1