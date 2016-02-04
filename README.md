# Docker ProcessWire

[![Go to Docker Hub](https://img.shields.io/badge/Docker%20Hub-%E2%86%92-blue.svg)](https://hub.docker.com/r/suzel/docker-processwire/)

A Dockerfile that installs the latest nginx, php, php-apc, mysql and processwire.

## Installation

The easiest way to get this docker image installed is to pull the latest version from the Docker registry:

```
$ docker pull suzel/docker-processwire
```

Build the docker-processwire:

```sh
$ git clone https://github.com/suzel/docker-processwire.git
$ cd docker-processwire/
$ docker build -t suzel/docker-processwire .
```

## Usage

Start your image binding external port 80 in all interfaces to your container:

```sh
$ docker run --name webproject \
             -v $PWD:/usr/share/nginx \
             -p 80:80 -p 3306:3306 \
             -e MYSQL_DB=processwire \
             -e MYSQL_USER=processwire \
             -e MYSQL_PASS=processwire \
             -d suzel/docker-processwire
```

You can the visit the following URL in a browser on your host machine to get started:

```
open http://$(docker-machine ip default):80
```