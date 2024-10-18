#!/bin/bash

# echo Enter the desired domain in the format of \"test.com\":
# read -a domain

# for elem in ${domains[@]}; do
#    TRAEFIK_DOMAIN+=" \`$elem\`,"
#    NGINX_DOMAIN+=" $elem"
# done

# echo $TRAEFIK_DOMAIN
# sudo sed -i "s/Host([^)]*)/Host(\`${domain[@]}\`)/g" docker-compose.yml
# sudo sed -i "s/NGINX_HOST=[^)]*/NGINX_HOST=${domain[@]}/g" docker-compose.yml

# start bash -i ./start.sh
# alias defpass="echo 'YOUR_DOCKER_PASS"
# alias doccon="docker login -u YOUR_DOCKER_USER_NAME --password-stdin"
# defpass | doccon
docker pull slaweekq/outline_admin:latest
docker compose -p slaweekq stop || true
docker compose -p slaweekq down -v && docker compose -f ./docker-compose.* rm -sfv
# docker rmi $(docker images -q --no-trunc) || true
docker compose -f ./docker-compose.* -p slaweekq up -d

echo "Server started"
IP=$(curl api.ipify.org)
echo "################################################################"
echo Done! Create an A-type entry in your domain control panel, targeting $IP
echo "################################################################"

# docker logs outline_admin
# docker logs reverse-proxy
# docker logs web
# docker exec -it reverse-proxy ping web
