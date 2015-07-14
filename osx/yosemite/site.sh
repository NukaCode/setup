#! /bin/bash

# Colors
Color_Off='\033[0m'
Yellow='\033[0;33m'
Green='\033[1;32m'
Cyan='\033[0;36m'

read -p "Install local dashboard site? [Y/N]?  " installSite
case $installSite in
    [nN][oO]|[nN])
        echo -e "${Yellow}Skipping site install... $Color_Off"
        exit 0
        ;;
esac

########################################################################################################
############ Setting up
########################################################################################################
localDir=`pwd`
read -p "Where should the site be installed? [Full path] " siteDir

echo -e "${Green}Cloning the site to $siteDir... $Color_Off"
. site/git.sh

echo -e "${Green}Setting up nginx... $Color_Off"
. site/nginx.sh

read -p "Forward port 80 to $port? [Y/N]?  " portForward
case $portForward in
    [yY][eE][sS]|[yY])
        sudo nginx -s stop
        echo "rdr pass inet proto tcp from any to any port 80 -> 127.0.0.1 port $port" | sudo pfctl -ef -
        nginx
        ;;
esac

echo -e "${Green}Setting up the database... $Color_Off"
. site/mysql.sh

echo -e "${Green}Setting up the site basics... $Color_Off"
. site/setup.sh

echo -e "${Green}Adding the default site and group... $Color_Off"
. site/default.sh