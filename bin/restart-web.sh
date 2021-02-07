#!/bin/sh
RUN_DIR=`pwd`
cd ../system/etracs-web
docker-compose down
docker-compose up -d
docker-compose logs -f
cd $RUN_DIR
