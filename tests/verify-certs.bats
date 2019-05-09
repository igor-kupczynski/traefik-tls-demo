#!/usr/bin/env bats

# This script makes requests to the backend services via traefik
# and makes sure the returned certificates match the expectations.
#
# It requires [bats](https://github.com/bats-core/bats-core), install it with:
#
# $ sudo apt install bats   # on ubuntu
#
# $ brew install bats-core  # on macos

# get_certificate_subject <url> connects to localhost:443 presenting <url>
# in client hello and prints the certificate subject, e.g.
# `get_certificate_subject whoami.traefik.local` prints:
# subject=CN = whoami.traefik.local
function get_certificate_subject() {
    local URL=$1
    echo quit | openssl s_client -servername ${URL} -connect localhost:443 2>&1 | grep subject
}

@test "whoami.trafik.local presents correct certificate" {
    SUBJECT=$(get_certificate_subject whoami.traefik.local)
    echo ${SUBJECT}
    [[ "$SUBJECT" == *"whoami.traefik.local"* ]]
}

@test "snowflake.trafik.local presents correct certificate" {
    SUBJECT=$(get_certificate_subject snowflake.traefik.local)
    echo ${SUBJECT}
    [[ "$SUBJECT" == *"snowflake.traefik.local"* ]]
}
