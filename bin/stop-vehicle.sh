#!/bin/sh
RUN_DIR=`pwd`
cd ../appserver/vehicle
docker-compose down
cd $RUN_DIR
