#!/bin/sh
cd ~/docker/etracs && docker-compose down

cd ~/docker/gdx-client && docker-compose down

cd ~/docker/vehicle && docker-compose down

cd ~ && docker system prune -f
