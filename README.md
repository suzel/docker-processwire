# Docker ProcessWire

## Installation

Pull the ubuntu Docker:

```
sudo docker pull ubuntu:14.04
```

Git clone the repository: 

```sh
$ git clone https://github.com/suzel/docker-processwire.git
```

Build the docker-processwire:

```sh
$ cd docker-processwire/
$ sudo docker build -t processwire .
```

## Usage

Run the docker-processwire:

```sh
$ sudo docker run --name webproject -p 80:80 -d processwire
```

Run the docker-processwire with volume:

```sh
$ sudo docker run --name webproject -v /Users/user/websites/webproject:/usr/share/nginx -p 80:80 -d processwire
```

Point your browser to:

```
http://serverip
```