#!/bin/sh
RUN_DIR=`pwd`
cd ../appserver/etracs
docker-compose down
sleep 1
docker-compose up -d
docker-compose logs -f
cd $RUN_DIR
