#! /bin/bash
# This script intend to install a magento website fully functional.
# php7.1
# nginx
# mariadb

# Download magento shop files.

PUBLICK_KEY="321917537e9fb97818857db627483668"
PRIVATE_KEY="e7e3cec1745c3e673521943367f466ab"

read -p "Project name: " PROJECT_NAME
read -p "Magento version: " MAGENTO_VERSION

echo "Public key: $PUBLICK_KEY"
echo "Private key: $PRIVATE_KEY"

composer create-project --repository=https://repo.magento.com/ magento/project-community-edition=$MAGENTO_VERSION $PROJECT_NAME

# Run install for database

read -p "Base URL: " BASE_URL
read -p "Database name: " DB_NAME
read -p "Database user: " DB_USER
read -p "Database passwd: " DB_PASSWD

cd $PROJECT_NAME

bin/magento setup:install \
--base-url=http://${BASE_URL}/ \
--db-host=localhost \
--db-name=$DB_NAME \
--db-user=$DB_USER \
--db-password=$DB_PASSWD \
--backend-frontname=control \
--admin-firstname=admin \
--admin-lastname=admin \
--admin-email=myemail@gmail.com \
--admin-user=admin \
--admin-password=@dmin123 \
--language=en_US \
--currency=USD \
--timezone=America/Chicago \
--use-rewrites=1

php bin/magento setup:upgrade
php bin/magento setup:di:compile
php bin/magento setup:static-content:deploy
