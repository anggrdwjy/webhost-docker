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
echo -n "   Port Web          : "
read port
docker exec -it mysql mysql -uroot -pbaseball -e "CREATE DATABASE wp$user$act;"
docker run --name wp$user$act -e WORDPRESS_DB_HOST=mysql:3306 -e WORDPRESS_DB_USER=root -e WORDPRESS_DB_PASSWORD=baseball -e WORDPRESS_DB_NAME=wp$user$act --net=net_wordpress -p $port:80 -d wordpress
docker update --restart unless-stopped wp$user$act 
