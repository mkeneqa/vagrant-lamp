#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

apt-get install -y software-properties-common
add-apt-repository ppa:ondrej/php -y
apt-get update
apt-get install -y apache2
apt-get install -y php7.4
apt-get install -y git
apt-get install -y wget
apt-get install -y php-cli
apt-get install -y php-zip
apt-get install -y unzip
apt-get install -y curl
apt-get install -y php-xml
apt-get install -y php-mbstring
apt-get install -y php-xdebug
apt-get install -y php-ldap

# # set up mysql pass. !!DO NOT USE IN PRODUCTION
debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
apt-get install -y mysql-server
apt-get install -y php-mysql
apt-get install -y mysql-client

# Allow External Connections on your MySQL Service
sudo sed -i -e 's/bind-addres/#bind-address/g' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo sed -i -e 's/skip-external-locking/#skip-external-locking/g' /etc/mysql/mysql.conf.d/mysqld.cnf
mysql -u root -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root'; FLUSH privileges;"
sudo service mysql restart

# create client database
mysql -u root -proot -e "CREATE DATABASE myapp_db;"

curl -sS https://getcomposer.org/installer |php
chmod +x composer.phar
mv composer.phar /usr/local/bin/composer

mv myapp.conf /etc/apache2/sites-available/
mv ports.conf /etc/apache2/
mv apache2.conf /etc/apache2/

a2ensite myapp
a2dissite 000-default
a2enmod rewrite
a2enmod actions
a2enmod headers

# add xdebug settings to php.ini
echo 'xdebug.remote_port=9000' >> /etc/php/7.4/apache2/php.ini
echo 'xdebug.remote_enable=true' >> /etc/php/7.4/apache2/php.ini
echo 'xdebug.remote_connect_back=true' >> /etc/php/7.4/apache2/php.ini
echo 'xdebug.remote_autostart=on' >> /etc/php/7.4/apache2/php.ini
echo 'xdebug.remote_host=' >> /etc/php/7.4/apache2/php.ini
echo 'xdebug.max_nesting_level=1000' >> /etc/php/7.4/apache2/php.ini
echo 'xdebug.idekey=PHPSTORM' >> /etc/php/7.4/apache2/php.ini

apache2ctl restart
timedatectl set-timezone America/Edmonton

# install nodejs 14
cd
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs