#!/bin/bash

export PROJECTS_PATH="$(pwd)/../../api"
export HTTP_CONFIG="$(pwd)/config"
export HTTP_LOG="$(pwd)/log"
export DATABASE_PATH="$(pwd)/data"

echo $OSTYPE
case "$OSTYPE" in
  linux*)   LOCAL_IP=`ip route get 1 | awk '{print $NF;exit}'` ;;
  darwin*)  LOCAL_IP=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | grep -v '169') ;;
  win*)     LOCAL_IP=$( ipconfig | awk '/192.168.1/ {print $NF;exit}' ) ;;
  msys*)     LOCAL_IP=$( ipconfig | awk '/192.168.1/ {print $NF;exit}' ) ;;
esac

echo "Start Docker/XDebug in: $LOCAL_IP"
export XDEBUG_REMOTE_HOST=$LOCAL_IP
export XDEBUG_REMOTE_PORT=9001
export ELASTIC_HOST="${LOCAL_IP}:9200"

docker network create development 2> /dev/null
docker-compose -f docker-compose.yml up --force-recreate
