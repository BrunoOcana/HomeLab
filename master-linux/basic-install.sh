#!/bin/bash

apt update
apt install resolvconf net-tools vim curl ssh python3 -y

hostnamectl set-hostname Master-Linux
echo time.google.com >> /etc/ntp.conf && echo time.windows.com >> /etc/ntp.conf
timedatectl set-timezone UTC
timedatectl set-timezone America/Sao_Paulo
timedatectl set-ntp true

ip -c a
$ipaddress = `hostname -I`

cat <<EOF>> /etc/network/interfaces
auto ens33
#iface ens33 inet dhcp
iface ens33 inet static
address  /24
gateway 
dns-nameservers 8.8.8.8 1.1.1.1
EOF

echo "nameserver 127.0.0.1" >> /etc/resolvconf/resolv.conf.d/head
echo "nameserver 8.8.8.8" >> /etc/resolvconf/resolv.conf.d/head
echo "nameserver 1.1.1.1" >> /etc/resolvconf/resolv.conf.d/head

nano /etc/network/interfaces
systemctl restart networking.service
ip link set dev ens33 up
