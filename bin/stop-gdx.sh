#!/bin/sh
RUN_DIR=`pwd`
cd ../system/gdx-client
docker-compose down
cd $RUN_DIR
