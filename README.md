# Dev Baseline  
As the title suggests this is a set of commands to baseline an linux operating system instance ( virtual/physical ) as soon as the OS is installed.
Specifically :   
0. Configure ethernet interface, hostname, default dns server etc.
1. Installs updates based on the OS ( RHEL-X variant or Debian / Ubuntu variant )
2. Installs necessary packages for dev environment like vim, wget, unzip 
3. Installs/configures NTP to ensure correct log timestamps and syncs
4. Installs bashrc/dotfiles ( specific to my env but you can modify )
