#!/bin/sh
RUN_DIR=`pwd`
cd ../system/queue
docker-compose down
cd $RUN_DIR
