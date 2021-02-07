#!/bin/sh
RUN_DIR=`pwd`
cd ../email/mail-primary
docker-compose down
sleep 1
docker-compose up -d
docker-compose logs -f
cd $RUN_DIR
