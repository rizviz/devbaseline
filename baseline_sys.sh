#!/bin/bash
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

# Set ethernet interface to come up always on boot
sed -i 's/ONBOOT=no/ONBOOT=yes/g' /etc/sysconfig/network-scripts/ifcfg-$PUB_IFACE_NAME

# Optional Steps: If this host will be used as a  K8s nodes
# Turn the SELINUX Off to stop it from mucking around w/ file permissions
sed -i 's/SELINUX=permissive/SELINUX=disabled/g' /etc/selinux/config

# Turn Firewall Off or Add the ports you want to expose
systemctl stop firewalld
systemctl disable firewalld

# Extra Packages for Enterprise Linux (EPEL),
# packages for the RHEL & RHEL based distributions
# This has some interesting packages like ansible.
# Install EPEL & Update
dnf -y install epel-release
# If above doesnt work then do following for 7.x
#rpm -iUvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
dnf -y update

# Install necessary packages
dnf -y install vim rsync git unzip wget ntp ntpdate
dnf -y upgrade


# Configure NTP and other packages
systemctl start ntpd
systemctl enable ntpd
systemctl status ntpd
ntpdate -u -s 0.pool.ntp.org 1.pool.ntp.org 2.pool.ntp.org


# install the efficient bashrc profile for quick shortcuts. skip / change to suit your needs
./install_bash_profile.sh

# Before rebooting check w/ user
read -r -p "Are you sure you want to continue with system reboot? [Y/n]" response
 response=${response,,} # tolower
 if [[ $response =~ ^(no|n| ) ]]; then
    echo " Aborting Reboot. Please reboot manually to apply changes!"
    exit 1
 fi

shutdown -r now
