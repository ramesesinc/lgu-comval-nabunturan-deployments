#!/bin/sh
RUN_DIR=`pwd`
cd ../email/mail-primary
docker-compose down
cd $RUN_DIR
