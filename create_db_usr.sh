#!/bin/sh

# create random passwd
PASSWD="$(openssl rand -base64 12)"

# If /root/.my.cnf exists then it won't ask for root passwd
if [ -f /root/.my.cnf ]; then
	read -p "Please enter the NAME of the new database: " DBNAME
	read -p "Please enter the database CHARACTER SET! (ex: latin1, utf8, ...): " CHARSET
	echo "Creating new database..."
	mysql -e "CREATE DATABASE ${DBNAME} /*\!40100 DEFAULT CHARACTER SET ${CHARSET} */;"
	echo "Database successfully created!"
	echo "Showing existing databases..."
	mysql -e "show databases;"
	echo ""
	read -p "Please enter the NAME of the new database user: " USERNAME
	echo "Creating new user..."
	mysql -e "CREATE USER ${USERNAME}@localhost IDENTIFIED BY '${PASSWD}';"
	echo "User successfully created!"
    	echo "+ User: $USERNAME"
    	echo "+ DBName: $DBNAME"
   	echo "+ Passwd: $PASSWD"
	echo ""
	echo "Granting ALL privileges on ${DBNAME} to ${USERNAME}!"
	mysql -e "GRANT ALL PRIVILEGES ON ${DBNAME}.* TO '${USERNAME}'@'localhost';"
	mysql -e "FLUSH PRIVILEGES;"
	echo "We are good to go!"
	exit
	
# If /root/.my.cnf doesn't exist then it'll ask for root password	
else
	read -p "Please enter root MySQL password: " ROOTPASSWD
	read -p "Please enter the NAME of the new database: " DBNAME
	read -p "Please enter the database CHARACTER SET! (example: latin1, utf8, ...): " CHARSET
	echo "Creating new database..."
	mysql -uroot -p${ROOTPASSWD} -e "CREATE DATABASE ${DBNAME} /*\!40100 DEFAULT CHARACTER SET ${CHARSET} */;"
	echo "Database successfully created!"
	echo "Showing existing databases..."
	mysql -uroot -p${ROOTPASSWD} -e "show databases;"
	echo ""
	read -p "Please enter the NAME of the new database user: " USERNAME
	read -p "Please enter the PASSWORD for the new database user: " USERPASS
	echo "Creating new user..."
	mysql -uroot -p${ROOTPASSWD} -e "CREATE USER ${USERNAME}@localhost IDENTIFIED BY '${USERNAME}';"
	echo "User successfully created!"
    	echo "+ User: $USERNAME"
    	echo "+ DBName: $DBNAME"
   	echo "+ Passwd: $PASSWD"
	echo ""
	echo "Granting ALL privileges on ${DBNAME} to ${USERNAME}!"
	mysql -uroot -p${ROOTPASSWD} -e "GRANT ALL PRIVILEGES ON ${DBNAME}.* TO '${USERNAME}'@'localhost';"
	mysql -uroot -p${ROOTPASSWD} -e "FLUSH PRIVILEGES;"
	echo "You're good now :)"
	exit
fi
