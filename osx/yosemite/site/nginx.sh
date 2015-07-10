#! /bin/bash

# Create a default virtual host
# Set up the nginx config
read -p "What port should this run on? [Hit enter to leave as :80]  " port
port=${port:-80}

sed -e s/{{PATH}}/"$siteDir"/g -e s/{{PORT}}/"$port"/g ./files/default.template > ./dasher

# Move it to the proper location
mv ./dasher /usr/local/etc/nginx/sites-available/dasher

ln -sfv /usr/local/etc/nginx/sites-available/dasher /usr/local/etc/nginx/sites-enabled/dasher