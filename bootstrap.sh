#!/usr/bin/env bash

# Settings
MYSQL_HOST="localhost"
MYSQL_USER="root"
MYSQL_PASS="root"
MYSQL_NAME="typo3"

sudo -s

# Update OS
apt-get -y update
apt-get -y upgrade

# Install Apache
apt-get -y install apache2

if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi

# Install MySQL
debconf-set-selections <<< "mysql-server mysql-server/root_password password $MYSQL_PASS"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $MYSQL_PASS"
apt-get -y install mysql-server

# Create Database
mysql -h $MYSQL_HOST -u $MYSQL_USER -p$MYSQL_PASS -e "CREATE DATABASE $MYSQL_NAME CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

# Enable Apache Modules
a2enmod rewrite

# Restart Apache Server
service apache2 restart
