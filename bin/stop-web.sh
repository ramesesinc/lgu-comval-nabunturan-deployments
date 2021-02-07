#!/bin/sh
RUN_DIR=`pwd`
cd ../system/etracs-web
docker-compose down
cd $RUN_DIR
