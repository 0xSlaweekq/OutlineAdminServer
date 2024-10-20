#!/bin/bash

sudo apt update
sudo apt install -y\
  wget curl gpg net-tools nginx certbot python3-certbot-nginx apache2

sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT
sudo iptables-save

certbot certonly --standalone --agree-tos --register-unsafely-without-email -d ${domain[@]}
certbot renew --dry-run

# start bash -i ./start.sh
# alias defpass="echo 'YOUR_DOCKER_PASS"
# alias doccon="docker login -u YOUR_DOCKER_USER_NAME --password-stdin"
# defpass | doccon
docker pull slaweekq/outline_admin:latest
docker compose -p slaweekq stop || true
docker compose -p slaweekq down -v && docker compose -f ./docker-compose.* rm -sfv
# docker rmi $(docker images -q --no-trunc) || true
docker compose -f ./docker-compose.* -p slaweekq up -d

IP=$(curl api.ipify.org)
echo "################################################################"
echo Done, Server started! Create an A-type entry in your domain control panel, targeting $IP
echo "################################################################"


# echo Enter the desired domain in the format of \"test.com\":
# read -a domain

# for elem in ${domain[@]}; do
#    TRAEFIK_DOMAIN+=" \`$elem\`,"
#    NGINX_DOMAIN+=" $elem"
# done

# echo \`${domain[@]}\`
# sudo sed -i "s/Host([^)]*)/Host(\`${domain[@]}\`)/g" docker-compose.yml
# sudo sed -i "s/NGINX_HOST=[^)]*/NGINX_HOST=${domain[@]}/g" docker-compose.yml
