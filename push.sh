# start bash -i ./start.sh
# alias defpass="echo 'YOUR_DOCKER_PASS"
# alias doccon="docker login -u YOUR_DOCKER_USER_NAME --password-stdin"
# defpass | doccon


docker buildx build -f "docker/8.2/Dockerfile" -t slaweekq/outline_admin:latest --push .
docker compose -f ./docker-compose.* stop || true
docker compose -f ./docker-compose.* down -v && docker compose -f ./docker-compose.* rm -sfv

echo "My image: slaweekq/outline_admin:latest"
