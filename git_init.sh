#! /bin/bash

read -p "Git user name: " USER_NAME
read -p "Git user mail: " USER_EMAIL
read -p "Git text editor: " CORE_EDITOR

git config --global user.name "$USER_NAME"
git config --global user.email "$USER_EMAIL"
git config --global core.editor "$CORE_EDITOR"
