#! /bin/bash

# Install it
brew install nginx

# Setup auto start
sudo cp -v /usr/local/opt/nginx/*.plist /Library/LaunchDaemons/
sudo chown root:wheel /Library/LaunchDaemons/homebrew.mxcl.nginx.plist

# Set up the folders
mkdir -p /usr/local/etc/nginx/logs
mkdir -p /usr/local/etc/nginx/sites-available
mkdir -p /usr/local/etc/nginx/sites-enabled
mkdir -p /usr/local/etc/nginx/conf.d
mkdir -p /usr/local/etc/nginx/ssl

sudo chown :staff ~/Code
sudo chmod 775 ~/Code

# Get default nginx.conf
USER=`whoami`
rm /usr/local/etc/nginx/nginx.conf
mv ./files/nginx.conf /usr/local/etc/nginx/nginx.conf
sudo touch /usr/local/etc/nginx/nginx.pid
sudo chown $USER:admin /usr/local/etc/nginx/nginx.pid
sudo chown $USER:admin /usr/local/var/log/nginx/error.log

# Load php fpm
curl -L https://gist.github.com/frdmn/7853158/raw/php-fpm -o /usr/local/etc/nginx/conf.d/php-fpm

# Start it
sudo launchctl load /Library/LaunchDaemons/homebrew.mxcl.nginx.plist

# Make aliases
curl -L https://gist.github.com/frdmn/7853158/raw/bash_aliases -o /tmp/.bash_aliases
cat /tmp/.bash_aliases >> ~/.bash_aliases

if [ -f ~/.bash_profile ]; then
    echo "source ~/.bash_aliases" >> ~/.bash_profile
    . ~/.bash_profile
fi

if [ -f ~/.zshrc ]; then
    echo "source ~/.bash_aliases" >> ~/.zshrc
    . ~/.zshrc
fi