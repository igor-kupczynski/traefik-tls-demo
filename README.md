# Traefik TLS Demo

This is a demo project which shows how to use [traefik](https://traefik.io/) to 
expose a docker container on localhost.

We use trafik 1.7, as 2.0 is in alpha version at the time of writing.

## Usage

### Start up

```sh
$ docker-compose up
```

### Request

```sh
$ curl -H 'Host: whoami.traefik.local' localhost:80
Hostname: b86c41013d18
IP: 127.0.0.1
IP: 192.168.64.3
GET / HTTP/1.1
Host: whoami.traefik.local
User-Agent: curl/7.64.0
Accept: */*
Accept-Encoding: gzip
X-Forwarded-For: 192.168.64.1
X-Forwarded-Host: whoami.traefik.local
X-Forwarded-Port: 80
X-Forwarded-Proto: http
X-Forwarded-Server: 98553b54f66e
X-Real-Ip: 192.168.64.1
```
