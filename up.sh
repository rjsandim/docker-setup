#!/bin/bash

export PROJECTS_PATH="/Users/rjsandim/Projetos"
export HTTP_CONFIG="$(pwd)/config"
export HTTP_LOG="$(pwd)/log"
export DATABASE_PATH="$(pwd)/data"

case "$OSTYPE" in
  linux*)   LOCAL_IP=`ip route get 1 | awk '{print $NF;exit}'` ;;
  darwin*)  LOCAL_IP=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1') ;;
  win*)     LOCAL_IP=$( ipconfig | awk '/192.168.1/ {print $NF;exit}' ) ;;
  msys*)     LOCAL_IP=$( ipconfig | awk '/192.168.1/ {print $NF;exit}' ) ;;
esac

echo "Start Docker/XDebug in: $LOCAL_IP"
export XDEBUG_REMOTE_HOST=$LOCAL_IP
export XDEBUG_REMOTE_PORT=9001

docker network create sun 2> /dev/null
echo "Building web"
echo "conectando ao ip $XDEBUG_REMOTE_HOST"
docker-compose -f docker-compose.yml up --force-recreate 