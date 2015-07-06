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
read -p "Where should the site be installed?  " siteDir

echo -e "${Green}Cloning the site to $siteDir... $Color_Off"
. site/git.sh

echo -e "${Green}Setting up nginx... $Color_Off"
. site/nginx.sh

echo -e "${Green}Setting up the database... $Color_Off"
. site/mysql.sh

echo -e "${Green}Setting up the site basics... $Color_Off"
. site/setup.sh

echo -e "${Green}Adding the default site and group... $Color_Off"
. site/default.sh