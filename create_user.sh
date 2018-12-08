#!/bin/bash
# Creating user and add it to sudo group

# ask the user to imput the name of the user
read -p "Enter user name: " user_name
# add a user
sudo adduser $user_name
# add the new user to the sudo group
sudo usermod -aG sudo $user_name
# list all the groups in wich your new user is in.
sudo groups $user_name

