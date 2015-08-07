# Docker ProcessWire

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
$ docker build -t processwire .
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
             -d processwire
```

You can the visit the following URL in a browser on your host machine to get started:

```
http://127.0.0.1:80
```