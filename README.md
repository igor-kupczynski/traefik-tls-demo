# Traefik TLS Demo

This is a demo project which shows how to  use [traefik](https://traefik.io/) to terminate https connection to a docker container.

We use trafik 1.7, as 2.0 is in alpha version at the time of writing.

## Usage

### Prerequisites

Add the following lines to `/etc/hosts` to make sure they route to localhost:
``` 
127.0.0.1	whoami.traefik.local
```


### Generate certificates

`gen-certs.sh` generates the default server certificate for `*.traefik.local`.

```sh
$ bin/gen-certs.sh
$ tree certs/
certs/
├── server.crt
└── server.key

```

### Start up

```sh
$ docker-compose up
```

### Request

Http should redirect to https:

```sh
$ curl -v http://whoami.traefik.local
(...)
< HTTP/1.1 302 Found
< Location: https://whoami.traefik.local:443/
```

Traefik should present the certificate we generated earlier on https connections. Since this is a self-signed cert we need to use `--insecure`.

```sh 
$ curl --insecure -v https://whoami.traefik.local
(...)
* Server certificate:
*  subject: CN=*.traefik.local
*  start date: May  8 15:58:34 2019 GMT
*  expire date: May  5 15:58:34 2029 GMT
*  issuer: CN=*.traefik.local
*  SSL certificate verify result: self signed certificate (18), continuing anyway.
(...) 
Hostname: 1e8018f3d6a0
IP: 127.0.0.1
IP: 192.168.144.2
GET / HTTP/1.1
Host: whoami.traefik.local
User-Agent: curl/7.64.0
Accept: */*
Accept-Encoding: gzip
X-Forwarded-For: 192.168.144.1
X-Forwarded-Host: whoami.traefik.local
X-Forwarded-Port: 443
X-Forwarded-Proto: https
X-Forwarded-Server: 267b6b087334
X-Real-Ip: 192.168.144.1 
```
