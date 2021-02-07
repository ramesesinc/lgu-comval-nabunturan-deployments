#!/bin/sh
RUN_DIR=`pwd`
cd ../appserver/epayment
docker-compose down
cd $RUN_DIR
