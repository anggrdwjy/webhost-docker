#!/bin/bash
#author : Anggarda Saputra Wijaya. anggarda.wijaya@outlook.com. github.com/anggardawjy
#version : 0.2
#about : wordpress docker
echo "                                                    ";
echo "   ==============================================   ";
echo "              CREATE DOCKER CONTAINER               ";
echo "   ==============================================   ";
echo "                                                    ";
echo -n "   Username Account  : "
read user
echo -n "   Activation Key ID : "
read act
echo -n "   Port Web (64xxx)  : "
read port
echo -n "   MYSQL Container   : "
read sqlcont
echo -n "   Username MYSQL    : "
read userdb
echo -n "   Password MYSQL    : "
read passdb
echo -n "   Network Container : "
read netdb
echo "                                                    ";
echo "   ==============================================   ";
docker exec -it $sqlcont mysql -u$userdb -p$passdb -e "CREATE DATABASE wp$user$act;"
docker run --name wp$user$act -e WORDPRESS_DB_HOST=$sqlcont:3306 -e WORDPRESS_DB_USER=$userdb -e WORDPRESS_DB_PASSWORD=$passdb -e WORDPRESS_DB_NAME=wp$user$act --net=$netdb -p $port:80 -d wordpress
docker update --restart unless-stopped wp$user$act 
