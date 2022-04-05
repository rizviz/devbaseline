# Dev Baseline  
As the title suggests this is a set of commands to baseline an linux operating system instance ( virtual/physical ) as soon as the OS is installed.
Specifically :  

0. Configure ethernet interface, hostname, default dns server etc.
1. Installs updates based on the OS ( RHEL-X variant or Debian / Ubuntu variant )
2. Installs necessary packages for dev environment like vim, wget, unzip 
3. Installs/configures NTP to ensure correct log timestamps and syncs
4. Installs bashrc/dotfiles ( specific to my env but you can modify )

# Usage:  
You can use either of these on freshly installed OS : 
 1. curl -sSL https://tinyurl.com/osbaseline | bash   
 2. curl -sSL https://https://raw.githubusercontent.com/rizviz/devbaseline/master/baseline_sys.sh | bash

# Security NOTE
If you want to check before executing the scripts , remove " | bash " from the commands above, download and inspect the scripts and then execute them 
