#!/bin/bash

echo Installing everything you need...
if [[ $(which docker) && $(docker --version) && $(docker compose) ]]; then
   echo Docker установлен, продолжаем...
else
   echo "add repositore"
   apt update
   apt install -y ca-certificates curl gnupg lsb-release

   mkdir -p /etc/apt/keyrings
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
   echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
   chmod a+r /etc/apt/keyrings/docker.gpg
   echo "Complete add repository\n\n"

   echo "Install docker"
   apt update
   apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
   docker compose version
   echo "docker installed"
fi

docker network create traefik-public
echo Enter the desired domain in the format of \"test.com\":
read -a domain
TRAEFIK_DOMAIN="\`${domain[@]}\`"
NGINX_DOMAIN="${domain[@]}"

# for elem in ${domains[@]}; do
#    TRAEFIK_DOMAIN+=" \`$elem\`,"
#    NGINX_DOMAIN+=" $elem"
# done

echo $TRAEFIK_DOMAIN
sudo sed -i "s/Host([^)]*)/Host($TRAEFIK_DOMAIN)/g" docker-compose-app.yml
sudo sed -i "s/Host([^)]*)/Host($TRAEFIK_DOMAIN)/g" docker-compose-nginx.yml
sudo sed -i "s/NGINX_HOST=[^)]*/NGINX_HOST=$NGINX_DOMAIN/g" docker-compose-nginx.yml

IP=$(curl api.ipify.org)
echo Done! Create an A-type entry in your domain control panel, targeting $IP

# start bash -i ./start.sh
# alias defpass="echo 'YOUR_DOCKER_PASS"
# alias doccon="docker login -u YOUR_DOCKER_USER_NAME --password-stdin"
# defpass | doccon
docker compose -p slaweekq stop || true
docker compose -p slaweekq down -v && docker compose rm -sfv
# docker rmi $(docker images -q --no-trunc) || true

docker compose --env-file ./.env -p slaweekq up -d
# docker push slaweekq/outline_admin:latest
docker compose -f ./docker-compose-app.* --env-file ./.env -p slaweekq up -d
docker compose -f ./docker-compose-nginx.* --env-file ./.env -p slaweekq up -d

echo "My image: slaweekq/outline_admin:latest"
echo "Server started"
