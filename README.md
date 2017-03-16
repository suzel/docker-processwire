# ProcessWire Docker Image
[![Go to Docker Hub](https://img.shields.io/badge/Docker%20Hub-%E2%86%92-blue.svg)](https://hub.docker.com/r/suzel/docker-processwire/)

A Docker container for Processwire Projects.

## Installation

The easiest way to get this docker image installed is to pull the latest version from the Docker registry:

```
$ docker pull suzel/docker-processwire
```

or build from scratch:

```sh
$ git clone https://github.com/suzel/docker-processwire.git
$ cd docker-processwire
$ docker build -t suzel/docker-processwire .
```

## Usage

Start your image binding external port 80 in all interfaces to your container:

```sh
$ docker run --name pw-project \
             -v $PWD:/var/www/pw \
             -p 80:80 \
             -d suzel/docker-processwire
```

You can the visit the following URL in a browser on your host machine to get started:

```
$ open http://<docker_ip_address>
```

## Documentation

* [ProcessWire Project](https://www.processwire.com)
* [ProcessWire Documentation](https://www.processwire.com/docs/)