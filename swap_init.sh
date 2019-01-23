#!/bin/sh
# creating swap partition

# check system swap
swapon -s
# create swap file
fallocate -l 2G /swapfile
chmod 600 /swapfile
# make it swap
mkswap /swapfile
# enable swap
swapon /swapfile
# setup swap permanent
echo "/swapfile		none	swap	sw	0	0" >> /etc/fstab
# setup kernel parameter
echo "vm.swappiness=10" >> /etc/sysctl.conf
# reload sysctl configuration
sysctl -p
