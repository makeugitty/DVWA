!#/bin/bash

echo "Updating the System"
sudo apt update && sudo apt upgrade -y

echo "System updated and upgraded!"

# Update install all the packages
echo "Installing all the packages..."
sudo apt install php apache2 libapache2-mod-php php-mysql mysql -y


sudo mysql_securestallation <<EOF
y
password
password
y
y
y
y
EOF

echo "Cloning DVWA repository"
cd /var/www/html
sudo git clone https://github.com/digininja/DVWA.git
sudo chown -R www-data:www-data /var/www/htlm/DVWA
sudo chmod -R 755 /var/www/html/DVWA

echo "Configuring DVWA"
sudo cp /var/www/html/DVWA/config config.inc.php.dist config.inc.php

echo "Create mysql user"
echo "If this doesn't work go to a terminal and dollow the commands in the script for mysql user"
sudo mysql -u root -p
password
CREATE DATABASE dvwa;
CREATE USER 'dvwauser'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON dvwa*. TO 'dvwauser'@'localhost';
FLUSH PRIVILEGES;
EXIT;

echo "Configure PHP"
PHP_VERSION=$(php -r "echo PHP_MAJOR_VERSION.'.'.PHPMINOR_VERSION;")
sudo sed -i "s/allow_url_include = off/allow_url_include =on/g" /etc/php/8.2/apache2/php.ini
sudo sed -i "s/allow_url_fopen = off/allow_url_fopen =on/g" /etc/php/8.2/apache2/php.ini
sudo sed -i "s/display_errors = off/display_errors=on/g" /etc/php/8.2/apache2/php.ini

echo "Restart apache2 and mySQL"
sudo service apache2 restart
sudo service mysql restart


echo " DVWA installation complete.. if you want to update any of the setting please do so in php.ini"
