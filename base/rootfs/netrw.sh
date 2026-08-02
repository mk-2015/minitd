#!/bin/sh

ip link set eth0 up
DHCP=0  
while getopts "n" opt; do
  case ${opt} in
    n)
      DHCP=1
      ;;
    \?)
      echo "Usage: $0 [-n]"
      exit 1
      ;;
  esac
done

if [ "$DHCP" -eq 1 ]; then
    udhcpc -i eth0 -q -n
    busybox route add default gw 192.168.1.254 eth0
else
    busybox ifconfig eth0 192.168.1.150 netmask 255.255.255.0 up
    busybox route add default gw 192.168.1.254 eth0
fi

echo "nameserver 1.1.1.1" > /etc/resolv.conf
echo "nameserver 8.8.8.8" >> /etc/resolv.conf
echo "nameserver 9.9.9.9" >> /etc/resolv.conf
echo "nameserver 4.2.2.2" >> /etc/resolv.conf