#! /bin/sh


# Create .my.cnf in the root directory to be able to use "mysql -uroot"
sudo touch /.my.cnf
echo "[client]" > /root/.my.cnf
echo "user=root" >> /root/.my.cnf
echo "password=" >> /root/.my.cnf

# Install composer and magento
sudo curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
sudo chmod +x /usr/local/bin/composer

# check netstat command and make sure the HTTP port 80 is on the 'LISTEN' state.
netstat -plntu

# Download Magento 2
# Magento Access Keys
public_key="321917537e9fb97818857db627483668"
private_key="e7e3cec1745c3e673521943367f466ab"

composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition .

# Set Up Permissions
# it take to log time using this method.
find . -type d -exec chmod 700 {} \; && find . -type f -exec chmod 600 {} \;

# Create The Database
echo "CREATE DATABASE magento2" | mysql -uroot -p

# Command Line Installer
php bin/magento setup:install 
--base-url="http://localhost:8080/" 
--db-host="localhost" 
--db-name="magento2" 
--db-user="root" 
--db-password="" 
--admin-firstname="admin" 
--admin-lastname="admin" 
--admin-email="user@localhost.com" 
--admin-user="admin" 
--admin-password="@dmin123" 
--language="en_US" 
--currency="USD" 
--timezone="America/Chicago" 
--use-rewrites="1" 
--backend-frontname="admin"

