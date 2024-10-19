<p align="center">
    <img src="extra/logo/logo.svg" width="200" alt="Outline Logo">
</p>

<h2 align="center">Outline Admin</h2>

Outline Admin is a web interface for the Outline Manager API, providing a simple and user-friendly UI for managing VPN
servers.

## Added Features

- Ability to set expiration date for Access Keys
- QR Code for access keys

Feel free to contribute and make this project better!

## Installation - Docker

Before proceeding with the installation of Outline Admin, ensure that `docker` and `docker-compose` are installed on
your machine. Follow the instructions below:

```SHELL
bash -i ./start.sh
```
```SHELL
git clone https://github.com/0xSlaweekq/OutlineAdminServer.git
cd OutlineAdminServer
cp .env.example .env
chmod +x *.sh && ./start.sh && ./agent.sh
// or docker-compose up -d
```

```
# docker exec -it reverse-proxy ping web

# docker logs outline_admin
# docker logs reverse-proxy
# docker logs web
```
http://outline.naumov.company/
Once the container is up and running, you can access the admin panel by opening the following URL in your browser:

```
http://{your_server_ip_or_hostname}:9696
```

**Note** The default port is `9696`, but you can modify it in the `.env` file.

## Admin User

You can use the `agent.sh` script to manage the admin user. Run it using the following command:

```
sudo bash ./agent.sh
```

Once you run the script, you will be presented with the following options:

```
Select an option:
1. Create Admin User
2. Reset Admin Password
3. Exit
>>>
```

## Update

If you need to update to the latest version, follow these instructions:

1. Navigate to the project root directory.
2. Run `git fetch & git pull`.
3. Restart the Docker container.

## Screenshots

![Login](/extra/screenshots/login.png)
![Servers](/extra/screenshots/servers.png)
![New server form](/extra/screenshots/new-server.png)
![Server settings form](/extra/screenshots/server-settings.png)
![Access keys](/extra/screenshots/access-keys.png)
![QR Code modal](/extra/screenshots/qr-code.png)
![New access key form](/extra/screenshots/new-access-key.png)


## 💗 Donation

If you find this project useful and would like to support its development, you can make a donation.

### TON

```
UQDqd8rfkOq_TTUBzyMalvJhHeP4hPezjkSyA92mb24VK4Oh
```
