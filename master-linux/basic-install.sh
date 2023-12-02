#!/bin/bash

apt update
apt install resolvconf ntpd vim ssh python3 -y
systemctl enable ntpd; systemctl start ntpd

hostnamectl set-hostname Master-Linux
echo time.google.com >> /etc/ntp.conf; echo time.windows.com >> /etc/ntp.conf
timedatectl set-timezone UTC
timedatectl set-timezone America/Sao_Paulo
timedatectl set-ntp true

$ipaddress = ip address show | grep inet | awk '{print $2}'

touch configuring-ip.py
cat <<EOF>> configuring-ip.py
auto ens33
#iface ens33 inet dhcp
iface ens33 inet static
address  /24
gateway 
dns-nameservers
EOF