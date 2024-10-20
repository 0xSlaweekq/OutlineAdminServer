#!/bin/bash

# start bash -i ./start.sh
# alias defpass="echo 'YOUR_DOCKER_PASS"
# alias doccon="docker login -u YOUR_DOCKER_USER_NAME --password-stdin"
# defpass | doccon
docker pull slaweekq/outline_admin:latest
docker compose -f ./docker-compose.* stop || true
docker compose -f ./docker-compose.* down -v && docker compose -f ./docker-compose.* rm -sfv
# docker rmi $(docker images -q --no-trunc) || true
docker compose -f ./docker-compose.* up -d

IP=$(curl api.ipify.org)
echo "################################################################"
echo Done, Server started! Create an A-type entry in your domain control panel, targeting $IP
echo "################################################################"
