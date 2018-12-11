#! /bin/bash
# Create a database and add a new user
# Grant all privileges for new user on created database

# Create .my.cnf in the root directory to be able to use "mysql -uroot"
touch /.my.cnf
read -p "Passwd for mysql root account: " PASSWD_ROOT
echo "[client]" > /root/.my.cnf
echo "user=root" >> /root/.my.cnf
echo "password=$PASSWD_ROOT" >> /root/.my.cnf

# Generate database random passwd
DB_PASSWD="$(openssl rand -base64 12)"

# Create database user name
read -p "Magento 2 database user name: " DB_USER
echo "CREATE USER ${DB_USER}@localhost IDENTIFIED BY '${DB_PASSWD}';" | mysql -uroot
# Create database name
read -p "Magento 2 database name: " DB_NAME
echo "CREATE DATABASE $DB_NAME;" | mysql -uroot
# Grand database access
echo "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost';" | mysql -uroot
# flush privileges
echo "FLUSH PRIVILEGES;" | mysql -uroot
# Display database credentials
echo "+ Database user: $DB_USER"
echo "+ Database name: $DB_NAME"
echo "+ Database passwd: $DB_PASSWD"

