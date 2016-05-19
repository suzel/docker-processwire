#!/usr/bin/env bash

docker-machine start default
eval "$(docker-machine env default)"

docker build -t suzel/docker-processwire .

docker stop webproject && docker rm webproject

docker run --name webproject \
           -v $PWD:/usr/share/nginx \
           -p 80:80 \
           -p 3306:3306 \
           -e MYSQL_DB=pw_db \
           -e MYSQL_USER=pw_user \
           -e MYSQL_PASS=pw_pass \
           -d suzel/docker-processwire

open http://$(docker-machine ip default)
docker exec -it webproject bash