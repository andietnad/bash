#! /bin/sh
# Setup a magento2 dev env

# Creating user and add it to sudo group
# ask the user to imput the name of the user
read -p "Enter user name: " user_name
# add a user
sudo adduser $user_name
# add the new user to the sudo group
sudo usermod -aG sudo $user_name
# list all the groups in wich your new user is in.
sudo groups $user_name

#install nginx
sudo apt update && sudo apt install nginx
# enable nginx service
sudo systemctl enable nginx.service

#install mariadb server
sudo apt install mariadb-server
#enable mariadb service
sudo systemctl enable mysql.service
#secure MariaDB server by creating a 
#root password and disallowing remote root access.
sudo mysql_secure_installation


# check netstat command and make sure the HTTP port 80 is on the 'LISTEN' state.
netstat -plntu


# Set Up Permissions
# it take to log time using this method.
find . -type d -exec chmod 700 {} \; && find . -type f -exec chmod 600 {} \;

