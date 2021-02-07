#!/bin/sh
RUN_DIR=`pwd`
cd ../system/download
docker-compose down
cd $RUN_DIR
