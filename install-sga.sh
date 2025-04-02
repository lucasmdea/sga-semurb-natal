#!/bin/bash

# Install PHP 5.6 and other dependencies
sudo apt-get update
sudo apt-get install -y software-properties-common ca-certificates lsb-release apt-transport-https 
sudo LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php 
sudo apt-get update && sudo apt-get install -y php5.6-zip apache2 php5.6 php5.6-mysql php5.6-ldap curl php5.6-mcrypt mariadb-server

# Install Composer
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

# Install Novo SGA v1.5
sudo composer create-project novosga/novosga /var/www/html/novosga 1.5.1 -vvv
sudo chown -R www-data:www-data /var/www/html/novosga/

# Create MySQL database and user (ALTERE A SENHA DO BANCO DE DADOS!)
sudo mysql -e "CREATE DATABASE sgadb;"
sudo mysql -e "CREATE USER 'sgauser'@'localhost' IDENTIFIED BY 'sua_senha';"
sudo mysql -e "GRANT ALL PRIVILEGES ON sgadb.* TO 'sgauser'@'localhost';"

# Configure Apache
sudo sed -i 's|/var/www/html|/var/www/html/novosga/public|g' /etc/apache2/sites-available/000-default.conf
sudo sed -i 's|AllowOverride None|AllowOverride All|g' /etc/apache2/apache2.conf
echo 'date.timezone = America/Sao_Paulo' | sudo tee /etc/php/5.6/apache2/conf.d/datetimezone.ini
sudo a2enmod rewrite
sudo service apache2 restart

# In .bashrc
sudo service mariadb start
sudo service apache2 start
