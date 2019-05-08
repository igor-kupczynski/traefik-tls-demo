#!/bin/bash

SCRIPT_DIR=`dirname "$(readlink -f "$0")"`


CERT_DIR="$SCRIPT_DIR/../certs"
mkdir -p ${CERT_DIR}


function generate_cert_for_service() {
    SERVICE=$1

    openssl genrsa -out ${CERT_DIR}/${SERVICE}.key 2048

    SUBJ="/CN=${SERVICE}.traefik.local"
    openssl req -subj "${SUBJ}" \
        -new -x509 -sha256 -days 3650 \
        -key ${CERT_DIR}/${SERVICE}.key \
        -out ${CERT_DIR}/${SERVICE}.crt
}


generate_cert_for_service whoami
generate_cert_for_service snowflake
