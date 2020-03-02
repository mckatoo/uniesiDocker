#!/bin/sh

docker stack deploy -c docker-compose.yml teste
sleep 15
timeout 120 docker service logs -f teste_api
docker service logs -f teste_web
