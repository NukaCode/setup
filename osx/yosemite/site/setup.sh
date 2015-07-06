#! /bin/bash

echo -e "${Yellow}Downloading composer packages... $Color_Off"
composer install

echo -e "${Yellow}Generating a key... $Color_Off"
php artisan key:generate

echo -e "${Yellow}Gathering needed compoenents... $Color_Off"
sudo npm install
bower install

echo -e "${Yellow}Running migrations... $Color_Off"
php artisan migrate --seed

echo -e "${Yellow}Running dump-autoload... $Color_Off"
composer dump-autoload -o
php artisan optimize