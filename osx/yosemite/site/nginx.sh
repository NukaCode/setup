#! /bin/bash

# Create a default virtual host
# Set up the nginx config
echo -e "${Yellow}When deciding on a port, remember to stay at or above 1024...$Color_Off"
read -p "What port should this run on? [Hit enter to leave as :1024]  " port
port=${port:-1024}

SITE_PATH=`echo "$siteDir" | sed 's/\//\\\\\//g'`
sed -e s/{{PATH}}/"$SITE_PATH"/g -e s/{{PORT}}/"$port"/g ./files/default.template > ./dasher

# Move it to the proper location
mv ./dasher /usr/local/etc/nginx/sites-available/dasher

ln -sfv /usr/local/etc/nginx/sites-available/dasher /usr/local/etc/nginx/sites-enabled/dasher