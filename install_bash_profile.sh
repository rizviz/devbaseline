#!/bin/bash
# Dev environment setup installer by r00txs
# initial version = Dec 21, 2015
# Apache License 
# No warranties , express or implied . Use at your own risk.You've been warned
# This installer installs bash profile with alias and installs necessary packages
# required for functioning of commands/aliases being used 

yum -y install bind-utils net-tools

if [[ $OSTYPE == 'linux-gnu' ]]; then
   cp -f bashrc-profile  ~/.bashrc
   source ~/.bashrc
   clear
elif [[ $OSTYPE == 'darwin' ]]; then
   cp -f bashrc-profile ~/.bash_profile
fi
