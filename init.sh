#!/bin/bash
docker rm -f $(docker ps -aq)
docker build . -t chat:1.0 -f chat/Dockerfile
docker run -d -p 8000:5000 chat:1.0
docker run -d --name my-mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=pass mysql:8.0.30
sleep 602
docker exec my-mysql mysql -u root -ppass -e "CREATE USER 'app'@'172.17.0.2' IDENTIFIED WITH mysql_native_password BY 'pass';"
docker exec my-mysql mysql -u root -ppass -e "CREATE DATABASE mydb;"
docker exec my-mysql mysql -u root -ppass -e "GRANT CREATE, ALTER, DROP, INSERT, UPDATE, DELETE, SELECT, REFERENCES, RELOAD on *.* TO 'app'@'172.17.0.2' WITH GRANT OPTION;"
docker exec my-mysql mysql -u root -ppass -D mydb -e "CREATE TABLE chat (ID int,username varchar(30),message varchar(255),date varchar(255));"
