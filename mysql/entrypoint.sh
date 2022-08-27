#!/bin/bash
sleep 20
USER=root
PASS=root123

mysqladmin -h loclahost:3306 -u root -ppass processlist ###user should have mysql permission on remote server. Ideally you should use different user than root.

while true
do
 	if [ $? -eq 0 ]
        	then
                	echo "do nothing"
        	else
                	ssh remote_server_ip  ###remote server linux root server password should be shared with this server.
                	service mysqld start
 	fi
done

mysql -u root -ppass -e "CREATE USER 'app'@'172.17.0.1' IDENTIFIED WITH mysql_native_password BY 'pass';"
mysql -u root -ppass -e "CREATE DATABASE mydb;"
mysql -u root -ppass -e "GRANT CREATE, ALTER, DROP, INSERT, UPDATE, DELETE, SELECT, REFERENCES, RELOAD on *.* TO 'app'@'172.17.0.1' WITH GRANT OPTION;"
mysql -u root -ppass -D mydb -e "CREATE TABLE chat(ID int,username varchar(30),message varchar(255), date varchar(255));"
