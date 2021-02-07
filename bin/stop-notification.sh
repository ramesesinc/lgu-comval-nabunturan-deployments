#!/bin/sh
RUN_DIR=`pwd`
cd ../system/notification
docker-compose down
cd $RUN_DIR
