#! /bin/sh


# Create .my.cnf in the root directory to be able to use "mysql -uroot"
sudo touch /.my.cnf
echo "[client]" > /root/.my.cnf
echo "user=root" >> /root/.my.cnf
echo "password=" >> /root/.my.cnf

# Install composer and magento (check if you need all those sudo)
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

# Generate database passwd automatically
db_passwd="$(openssl rand -base64 12)"
# Create database user name
read -p "Enter magento 2 database user name: " db_user
echo "CREATE USER ${db_user}@localhost IDENTIFIED BY '${db_passwd}';" | mysql -uroot
# Create database name
read -p "Enter magento 2 database name: " db_name
echo "CREATE DATABASE $db_name;" | mysql -uroot
# Grand database access
echo "GRANT ALL PRIVILEGES ON ${db_name}.* TO '${db_user}'@'localhost';" | mysql -uroot
# flush privileges
echo "FLUSH PRIVILEGES;" | mysql -uroot
# Display database credentials
echo "+ user: $db_user"
echo "+ db name: $db_name"
echo "+ passwd: $db_passwd"

base_url=""
admin_passwd=""

# Command Line Installer
php bin/magento setup:install 
--base-url="http://${base_url}:8080/" 
--db-host="${base_url}" 
--db-name="${db_name}" 
--db-user="${db_user}" 
--db-password="${db_passwd}" 
--admin-firstname="admin" 
--admin-lastname="admin" 
--admin-email="user@${base_url}.com" 
--admin-user="admin" 
--admin-password="${admin_passwd}" 
--language="en_US" 
--currency="USD" 
--timezone="America/Chicago" 
--use-rewrites="1" 
--backend-frontname="admin"

