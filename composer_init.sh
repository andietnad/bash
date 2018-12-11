#!/bin/sh
# Install composer
# This must be run as root.

curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
chmod +x /usr/local/bin/composer

