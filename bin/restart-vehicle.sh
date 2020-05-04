#!/bin/sh
cd ~/docker/vehicle
docker-compose down
docker system prune -f
sleep 2
docker-compose up -d
docker-compose logs -f local-vehicle-server
cd ~
