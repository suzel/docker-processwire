# Docker ProcessWire

## Installation

Git clone the repository: 

<code>git clone https://github.com/suzel/docker-processwire.git</code>

Pull the ubuntu Docker:

<code>sudo docker pull ubuntu:14.04</code>

Build the docker-processwire:

<code>sudo docker build -t processwire .</code>

## Usage

Run the docker-processwire:

<code>sudo docker run --name webproject -p 80:80 -d processwire</code>

Run the docker-processwire with volume:

<code>sudo docker run --name webproject -v /Users/user/websites/webproject:/usr/share/nginx/www -p 80:80 -d processwire</code>

Point your browser to:

<code>http://serverip</code>
