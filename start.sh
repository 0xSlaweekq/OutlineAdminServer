#!/bin/bash

sudo apt update
sudo apt install -y\
  wget curl gpg net-tools nginx certbot python3-certbot-nginx apache2

sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 8080 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 3128 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 2525 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 2053 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 3333 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 37280 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 58628 -j ACCEPT

# sudo ufw allow 22/tcp
# sudo ufw allow 443/tcp
# sudo ufw allow 8080/tcp
# # 3proxy
# sudo ufw allow 3128/tcp
# sudo ufw allow 2525/tcp
# # 3xui
# sudo ufw allow 2053/tcp
# sudo ufw allow 3333/tcp
# # outline
# sudo ufw allow 37280/tcp
# sudo ufw allow 58628/tcp
# sudo ufw allow 58628/udp

sudo iptables-save

echo Enter the desired domain in the format of \"test.com\":
read -a domain

certbot certonly --standalone --agree-tos --register-unsafely-without-email -d ${domain[@]}
certbot renew --dry-run

# for elem in ${domain[@]}; do
#    TRAEFIK_DOMAIN+=" \`$elem\`,"
#    NGINX_DOMAIN+=" $elem"
# done

# echo \`${domain[@]}\`
# sudo sed -i "s/Host([^)]*)/Host(\`${domain[@]}\`)/g" docker-compose.yml
# sudo sed -i "s/NGINX_HOST=[^)]*/NGINX_HOST=${domain[@]}/g" docker-compose.yml


chmod +x ./*.sh
./init.sh
