#!/bin/sh

# create random passwd
PASSWD="$(openssl rand -base64 12)"

# If /root/.my.cnf exists then it won't ask for root passwd
if [ -f /root/.my.cnf ]; then
	echo "Please enter the NAME of the new database!"
	read dbname
	echo "Please enter the database CHARACTER SET! (ex: latin1, utf8, ...)"
	read charset
	echo "Creating new database..."
	mysql -e "CREATE DATABASE ${dbname} /*\!40100 DEFAULT CHARACTER SET ${charset} */;"
	echo "Database successfully created!"
	echo "Showing existing databases..."
	mysql -e "show databases;"
	echo ""
	echo "Please enter the NAME of the new database user!"
	read username
	echo "Creating new user..."
	mysql -e "CREATE USER ${username}@localhost IDENTIFIED BY '${PASSWD}';"
	echo "User successfully created!"
    	echo "+ User: $username"
   	echo "+ Passwd: $PASSWD"
	echo ""
	echo "Granting ALL privileges on ${dbname} to ${username}!"
	mysql -e "GRANT ALL PRIVILEGES ON ${dbname}.* TO '${username}'@'localhost';"
	mysql -e "FLUSH PRIVILEGES;"
	echo "We are good to go!"
	exit
	
# If /root/.my.cnf doesn't exist then it'll ask for root password	
else
	echo "Please enter root user MySQL password!"
	read rootpasswd
	echo "Please enter the NAME of the new database!"
	read dbname
	echo "Please enter the database CHARACTER SET! (example: latin1, utf8, ...)"
	read charset
	echo "Creating new database..."
	mysql -uroot -p${rootpasswd} -e "CREATE DATABASE ${dbname} /*\!40100 DEFAULT CHARACTER SET ${charset} */;"
	echo "Database successfully created!"
	echo "Showing existing databases..."
	mysql -uroot -p${rootpasswd} -e "show databases;"
	echo ""
	echo "Please enter the NAME of the new database user!"
	read username
	echo "Please enter the PASSWORD for the new database user!"
	read userpass
	echo "Creating new user..."
	mysql -uroot -p${rootpasswd} -e "CREATE USER ${username}@localhost IDENTIFIED BY '${userpass}';"
	echo "User successfully created!"
    	echo "+ User: $username"
   	echo "+ Passwd: $PASSWD"
	echo ""
	echo "Granting ALL privileges on ${dbname} to ${username}!"
	mysql -uroot -p${rootpasswd} -e "GRANT ALL PRIVILEGES ON ${dbname}.* TO '${username}'@'localhost';"
	mysql -uroot -p${rootpasswd} -e "FLUSH PRIVILEGES;"
	echo "You're good now :)"
	exit
fi
