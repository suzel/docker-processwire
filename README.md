# Docker ProcessWire

## Installation

Git clone the repository: 

```
git clone https://github.com/suzel/docker-processwire.git
```

Pull the ubuntu Docker:

```
sudo docker pull ubuntu:14.04
```

Build the docker-processwire:

```
sudo docker build -t processwire .
```

## Usage

Run the docker-processwire:

```
sudo docker run --name webproject -p 80:80 -d processwire
```

Run the docker-processwire with volume:

```
sudo docker run --name webproject -v /Users/user/websites/webproject:/usr/share/nginx/www -p 80:80 -d processwire
```

Point your browser to:

```
http://serverip
```