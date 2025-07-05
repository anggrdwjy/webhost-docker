#!/bin/bash
#author : Anggarda Saputra Wijaya. anggarda.wijaya@outlook.com. github.com/anggardawjy
#version : 0.1
#about : setup server docker
#=====Initiation Package=====#
apt update && apt upgrade -y
apt install software-properties-common -y
apt install docker.io -y
#
#=====Create Image Docker=====#
docker pull mysql 
docker pull wordpress
docker pull portainer/portainer-ce:lts
docker pull jlesage/nginx-proxy-manager
#
#=====Create Volume Docker=====#
docker volume create db_wordpress
docker volume create portainer_data
#
#=====Create Network Docker=====#
docker network create net_wordpress
docker network create net_localhost
#
#=====Installing Docker Container MYSQL & Portainer=====#
docker run --name mysql -e MYSQL_ROOT_PASSWORD=baseball -v db_wordpress:/var/lib/mysql --net=net_wordpress -d mysql
docker run --name portainer -p 8000:8000 -p 9443:9443 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data --net=net_localhost -d portainer/portainer-ce:lts
docker run --name nginx-proxy-manager -p 8181:8181 -p 8080:8080 -p 4443:4443 -v /docker/appdata/nginx-proxy-manager:/config:rw --net=net_localhost -d jlesage/nginx-proxy-manager
docker update --restart unless-stopped mysql portainer nginx-proxy-manager
#
#
#container mysql : user-default:root/password:baseball
#container portainer : user-default:admin/password:(create own password), access web portainer : https://ip-address:9443 (default web)
#container nginx-proxy-manager : user-default:admin@example.com/password:changeme. access web nginx-proxy-manager : https://ip-address:8181 (default web)
#
#

