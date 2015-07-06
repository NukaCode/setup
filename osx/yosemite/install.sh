#! /bin/bash

echo 'Starting the installer...'

########################################################################################################
############ Xcode
########################################################################################################
echo -e "${Green}Installing xcode (click install)..."
. install/xcode.sh

echo 'Open Xcode, hit ⌘ + , to access the Preferences and navigate to the Locations tab. Set the Command Line Tools to the latest version available...'
read -p "Press [Enter] when done ..."

########################################################################################################
############ Git
########################################################################################################
echo -e "${Green}Setting up common git aliases..."
. git.sh

########################################################################################################
############ Homebrew
########################################################################################################
variable=`brew -v 2> /dev/null`
rc=$?

if [[ $rc != 0 ]]
then
    echo -e "${Green}Installing homebrew... $Color_Off"
    . install/homebrew.sh
else
    echo -e "${Cyan}Homebrew already installed... $Color_Off"
fi

read -p "Update homebrew [Y/N]?  " upbrew
case upbrew in
    [yY][eE][sS]|[yY])
        echo -e "${Green}Updating homebrew... $Color_Off"
        . update/homebrew.sh
        ;;
esac

########################################################################################################
############ Composer
########################################################################################################
variable=`composer --version 2> /dev/null`
rc=$?

if [[ $rc != 0 ]]
then
    echo -e "${Green}Installing composer... $Color_Off"
    . install/composer.sh
else
    echo -e "${Cyan}Composer already installed... $Color_Off"
fi

variable=`laravel --version 2> /dev/null`
rc=$?

if [[ $rc != 0 ]]
then
    echo -e "${Green}Installing laravel installer... $Color_Off"
    . install/laravel_installer.sh
else
    echo -e "${Cyan}Laravel installer already installed... $Color_Off"
fi

variable=`envoy --version 2> /dev/null`
rc=$?

if [[ $rc != 0 ]]
then
    echo -e "${Green}Installing Laravel Envoy... $Color_Off"
    . install/laravel_envoy.sh
else
    echo -e "${Cyan}Laravel envoy already installed... $Color_Off"
fi

echo -e "${Green}Updating locate database... $Color_Off"
sudo /usr/libexec/locate.updatedb

########################################################################################################
############ MySQL
########################################################################################################
variable=`mysql --version 2> /dev/null`
rc=$?

if [[ $rc != 0 ]]
then
    echo -e "${Green}Installing mysql... $Color_Off"
    . install/mysql.sh
else
    echo -e "${Cyan}Mysql already installed... $Color_Off"
fi

. install/mysql_database.sh

########################################################################################################
############ PHP
########################################################################################################
echo -e "${Green}Installing PHP... $Color_Off"
. install/php.sh

########################################################################################################
############ Nginx
########################################################################################################
variable=`nginx -v 2> /dev/null`
rc=$?

if [[ $rc != 0 ]]
then
    echo -e "${Green}Installing Nginx... $Color_Off"
    . install/nginx.sh
else
    echo -e "${Cyan}Nginx already installed... $Color_Off"
fi

########################################################################################################
############ Node
########################################################################################################
variable=`node -v 2> /dev/null`
rc=$?

if [[ $rc != 0 ]]
then
    echo -e "${Green}Installing Node... $Color_Off"
    . install/node.sh
else
    echo -e "${Cyan}Node already installed... $Color_Off"
fi

read -p "Update npm [Y/N]?  " upnpm
case upnpm in
    [yY][eE][sS]|[yY])
        echo -e "${Green}Updating NPM... $Color_Off"
        . update/node.sh
        ;;
esac

########################################################################################################
############ Bower
########################################################################################################
variable=`bower -v 2> /dev/null`
rc=$?

if [[ $rc != 0 ]]
then
    echo -e "${Green}Installing Bower... $Color_Off"
    . install/bower.sh
else
    echo -e "${Cyan}Bower already installed... $Color_Off"
fi

#########################################################################################################
############ Gulp
########################################################################################################
variable=`gulp -v 2> /dev/null`
rc=$?

if [[ $rc != 0 ]]
then
    echo -e "${Green}Installing Gulp... $Color_Off"
    . install/gulp.sh
else
    echo -e "${Cyan}Gulp already installed... $Color_Off"
fi

########################################################################################################
############ Finishing the Site
########################################################################################################
echo -e "${Yellow}Downloading composer packages... $Color_Off"
composer install
echo -e "${Yellow}Generating a key... $Color_Off"
php artisan key:generate
echo -e "${Yellow}Gathering needed compoenents... $Color_Off"
sudo npm install
bower install
echo -e "${Yellow}Running migrations... $Color_Off"
php artisan migrate --seed
composer dump-autoload -o
php artisan optimize

########################################################################################################
############ Grant the site visudo permission to nginx
########################################################################################################
echo "Please add the following line at the end of the file that is about to pop up  [Press enter when ready]..."
user=`whoami`
nginx=`which nginx`
read -p "$user   ALL=(ALL) NOPASSWD: $nginx"
sudo visudo

echo 'Finished with initial install!'