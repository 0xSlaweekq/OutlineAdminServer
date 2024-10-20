#!/bin/bash

sudo apt update
sudo apt install -y\
  wget curl gpg net-tools nginx certbot python3-certbot-nginx

wget http://ftp.ru.debian.org/debian/pool/main/o/openssl/libssl1.1_1.1.1w-0+deb11u1_amd64.deb && \
dpkg -i libssl1.1_1.1.1w-0+deb11u1_amd64.deb && \
rm libssl1.1_1.1.1w-0+deb11u1_amd64.deb

sudo sed -i 32i\ 'include /etc/nginx/sites-enabled/*;' /etc/nginx/nginx.conf
systemctl restart nginx


sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT
sudo iptables-save

sudo mkdir -m 777 -p /var/www/naumov.company /etc/nginx/sites-available /etc/nginx/sites-enabled
sudo chown -R www-data:www-data /var/www/naumov.company

sudo bash -c \
"cat << EOF > /var/www/naumov.company/index.html
<html>
    <head>
        <title>Hello World</title>
    </head>
    <body>
        <span>Success!</span>
    </body>
</html>
EOF"


sydo cp ./nginx/templates/default.conf.template /etc/nginx/sites-available/naumov.company
sudo ln -s /etc/nginx/sites-available/naumov.company /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx

curl -o- https://raw.githubusercontent.com/0xJacky/nginx-ui/master/install.sh | sudo bash
