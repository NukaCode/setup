# Goal

The goal of this repo is to make the task of setting up a local dev box a non-issue.  This script installs all the programs needed to get up and running.

Once this install is done, the <local-dashboard> repository is great for setting up sites (nginx/homestead) and even generating new Laravel sites that display immediately.

- [Installation](#installation)
- [What is installed](#what-is-installed)

# <a name="installation"></a> Installation

To begin, download the zip/tar file that corresponds to the OS you will be running this one.  Once you have downloaded the archive, extract it and run install.sh.

## Mac OSX

### Yosemite

	curl -s <github link>
	unzip <filename>
	chmod 755 ./install.sh
	./install.sh

## Ubuntu

### 14.04

	curl -s <github link>
	tar -xvzf <filename>
	chmod 755 ./install.sh
	./install.sh

# <a name="things-to-note"></a> Things to note

The installer will ask for your root password throughout the installation.  This is done to run commands with sudo.  Since this is all done locally, nothing is shared, stored, sent or made visible to anything outside of your local computer.

# <a name="what-is-installed"></a> What all is installed

## Mac OSX

### Yosemite

- Xcode CLI Tools
- Common Git Aliases
- Homebrew
- Composer
- Laravel Installer
- MySql
- PHP (5.6)
- Nginx
- Node
- Bower
- Gulp

## Ubuntu

### 14.04

- Git
- Common Git Aliases
- PHP (5.6)
- Composer
- Laravel Installer
- MySQL
- Nginx
- Node
- Bower
- Gulp