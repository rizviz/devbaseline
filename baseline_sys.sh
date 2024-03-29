#!/bin/bash
# Updated v4: 09/20/2023 : Updates to timezone and cleanups
# Updated v3: 04/02/2022 : RockyLinux updates
# Updated v2: 10/3/2017
# Original Version Date : 12/1/2014
# Author : Zeeshan Rizvi / @zeerizvi
# Purpose : Baseline a development VM/System for development/testing
# Tasks Performed by this include disabling selinux , disabling firewall, disabling firewall
# copying common shortcuts/rc files, installing pkgs needed for development like
# vim, net-tools,git, ansible etc.,  updating the system & finally rebooting
# Apache License: All warranties null & void , use at your own risk

# TODO : Check if its ubunutu or redhat based system & issue install commands accordingly
# TODO : Check for user is root or not

# Change to root directory
cd /root

export PUB_IFACE_NAME=`ip addr | grep -i broadcast | awk '{ print $2 }'| sed 's/:/\ /g' | head -1`
echo $PUB_IFACE_NAME
export PUB_IFACE_MAC=`ip addr | grep -i ether | awk {'print $2'} | head -1`
export LAST5MAC=`echo $PUB_IFACE_MAC  | sed s/://g | cut -c 8-12`
# Set ethernet interface to come up always on boot
sed -i 's/ONBOOT=no/ONBOOT=yes/g' /etc/sysconfig/network-scripts/ifcfg-$PUB_IFACE_NAME
# Set hostname with last4 digits of the node MAC address
hostnamectl set-hostname "node-$LAST5MAC"
# Set DNS server , change to your liking , using cloudflare's
echo "nameserver 1.1.1.1" >> /etc/resolv.conf

# Optional Steps: If this host will be used as a K8s nodes, comment if not needed
 # 1. Turn the SELINUX Off to stop it from mucking around w/ file permissions
 sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

 # 2. Turn off Swap and comment out fstab for persistence
 swapoff -a
 sed -i '/rl-swap/s/^/#/g' /etc/fstab

# Optional:  Turn Firewall Off or Add the ports you want to expose
#systemctl stop firewalld
#systemctl disable firewalld

# Extra Packages for Enterprise Linux (EPEL),
# packages for the RHEL & RHEL based distributions
# This has some interesting packages like ansible.
# Install EPEL & Update
dnf -y install epel-release
# If above doesnt work then do following for 7.x
#rpm -iUvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
dnf -y update

# Install necessary packages
dnf -y install vim rsync git unzip wget open-vm-tools net-tools bind-utils
dnf -y upgrade


# Configure Timezone and NTP. Since we dont know timezone , grab using public IP and set accordingly.
timedatectl set-ntp true
export TIMEZONE= `curl ipinfo.io | grep timezone | awk '{print $2}' | sed 's/",//' | sed 's/\"//'`
timedatectl set-timezone $TIMEZONE

# Download and install the efficient bashrc profile for quick shortcuts. skip / change to suit your needs
curl https://raw.githubusercontent.com/rizviz/devbaseline/master/bashrc-profile --output bashrc.new
cp .bashrc bashrc.orig
cp bashrc.new .bashrc
source .bashrc


## Optional : Store all updates/changes in a file
echo "Hostname: `hostname`" > ~/OS_BASELINE.txt
 echo "Operating System: `hostnamectl | grep Operating`" >> ~/OS_BASELINE.txt
 echo "IP Address Local: `ifconfig -a | grep inet | head -1`" >> ~/OS_BASELINE.txt
 echo "IP Address WAN: `dig +short myip.opendns.com @resolver1.opendns.com`" >> ~/OS_BASELINE.txt
 echo "DNS Server: `nslookup cnn.com | grep Server`" >> ~/OS_BASELINE.txt
 echo "Gateway IP: `ip route | grep default | awk '{print$3}' `" >> ~/OS_BASELINE.txt



# Before rebooting check w/ user
read -r -p "Are you sure you want to continue with system reboot? [Y/n]" response
 response=${response,,} # tolower
 if [[ $response =~ ^(no|n| ) ]]; then
    echo " Aborting Reboot. Please reboot manually to apply changes!"
    exit 1
 fi


shutdown -r now
