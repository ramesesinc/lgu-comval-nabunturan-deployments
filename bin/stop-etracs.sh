#!/bin/sh
RUN_DIR=`pwd`
cd ../appserver/etracs
docker-compose down
cd $RUN_DIR
