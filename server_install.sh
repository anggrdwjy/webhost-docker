#!/bin/bash
#author : Anggarda Saputra Wijaya. anggarda.wijaya@outlook.com. github.com/anggardawjy
#version : 0.1
#about : setup server docker
#=====Initiation Package=====#
apt update && apt upgrade -y
apt install docker.io
#
#=====Create Image Docker=====#
docker pull mysql 
docker pull wordpress
docker pull portainer/portainer-ce:lts
#
#=====Create Volume Docker=====#
docker volume create db_wordpress
docker volume create portainer_data
#
#=====Create Network Docker=====#
docker network create net_wordpress
#
#=====Installing Docker Container MYSQL & Portainer=====#
echo -n "   Create Root Password MYSQL  : "
read passwd
docker run --name mysql -e MYSQL_ROOT_PASSWORD=$passswd -v db_wordpress:/var/lib/mysql --net=net_wordpress -d mysql
docker run --name portainer -d -p 8000:8000 -p 9443:9443-v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:lts 
docker update --restart unless-stopped mysql portainer
#
