#!/bin/bash
if [[ $OSTYPE == 'linux-gnu' ]]; then
   cp -f bashrc-profile  ~/.bashrc
   source ~/.bashrc
   clear
elif [[ $OSTYPE == 'darwin' ]]; then
   cp -f bashrc-profile ~/.bash_profile
fi
