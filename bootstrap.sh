#!/usr/bin/env bash

# Settings
MYSQL_HOST="localhost"
MYSQL_USER="root"
MYSQL_PASS="root"
MYSQL_NAME="typo3"

sudo -s

apt-get -y install software-properties-common
add-apt-repository ppa:ondrej/php

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

# Install PHP
apt-get -y install libapache2-mod-php7.0
apt-get -y install php7.0
apt-get -y install php7.0-gd
apt-get -y install php7.0-mysql
apt-get -y install php7.0-soap
apt-get -y install php7.0-xml
apt-get -y install php7.0-zip

# Set Options in php.ini
sed -i "s/^max_execution_time.*/max_execution_time = 240/" /etc/php/7.0/apache2/php.ini
sed -i "s/^; max_input_vars.*/max_input_vars = 1500/" /etc/php/7.0/apache2/php.ini

# Enable Apache Modules
a2enmod rewrite

# Restart Apache Server
service apache2 restart
