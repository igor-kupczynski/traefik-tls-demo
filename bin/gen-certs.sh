#!/bin/bash

SCRIPT_DIR=`dirname "$(readlink -f "$0")"`
CERT_DIR="$SCRIPT_DIR/../certs"
CERT_SUBJ="/CN=*.traefik.local"

mkdir -p $CERT_DIR

openssl genrsa -out $CERT_DIR/server.key 2048

openssl req -new -x509 -sha256 -days 3650 -subj "$CERT_SUBJ" \
    -key $CERT_DIR/server.key \
    -out $CERT_DIR/server.crt
