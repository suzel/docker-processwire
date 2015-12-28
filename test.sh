#!/usr/bin/env bash

eval "$(docker-machine env default)"

docker build -t suzel/docker-processwire .

docker stop webproject
docker rm webproject

docker run --name webproject \
             -v $PWD:/usr/share/nginx \
             -p 80:80 -p 3306:3306 \
             -e MYSQL_DB=processwire \
             -e MYSQL_USER=processwire \
             -e MYSQL_PASS=processwire \
             -d suzel/docker-processwire

docker exec -it webproject bash