# Dev Baseline for OS
Standardizing your vm host/instance OS environment is key to ensuring a less stressful and more bug free development experience.
As the title suggests this is a set of scripts to baseline a linux operating system instance ( virtual/physical ) as soon as the OS is installed.
Specifically :  

0. Infra Components: Configure ethernet interface, hostname, default dns server, open-vm-tools, ntp (for correct log timestamps) etc.
1. OS Components: Installs updates based on the OS ( RHEL-X variant or Debian / Ubuntu variant ),  bashrc/dotfiles ( specific to my env but you can modify )
2. Dev Components: Installs necessary packages for dev environment like git,vim, wget, unzip 
3. Optional : If you plan to use instances for K8s deployment , additional steps can be uncommented before execution . Read through.

# Usage:  
You can use either of these on freshly installed OS : 
 1. curl -sSL https://tinyurl.com/osbaseline | bash   
 2. curl -sSL https://https://raw.githubusercontent.com/rizviz/devbaseline/master/baseline_sys.sh | bash

# Security NOTE
If you want to check before executing the scripts , remove " | bash " from the commands above to download and inspect the scripts and then execute them 
