help:
	@ echo "prerequistes :: setup the prerequites:"
	@ echo "                  - make sure the required entries exist in /etc/hosts"
	@ echo "                  - generate TLS certificates if not exist yet"
	@ echo
	@ echo "fg           :: start traefik and the backend services in foreground -- useful for debugging or experimentation"
	@ echo "up           :: start traefik and the backend services in background"
	@ echo "down         :: stop traefik and the backend services"
	@ echo
	@ echo "test         :: (re)start the services and run the tests"
	@ echo "                  - stop the services if tests are successful"


### Prerequites
.PHONY: check-hosts
check-hosts:
	@ grep 'whoami.traefik.local' /etc/hosts >/dev/null || (echo "Please add \"127.0.0.1       whoami.traefik.local\" to /etc/hosts" && exit 1)
	@ grep 'snowflake.traefik.local' /etc/hosts >/dev/null || (echo "Please add \"127.0.0.1       snowflake.traefik.local\" to /etc/hosts" && exit 1)

certs = certs/whoami.key certs/whoami.crt \
		certs/snowflake.key certs/snowflake.crt

$(certs):
	@ bin/gen-certs.sh

.PHONY: prerequistes
prerequistes: check-hosts $(certs)


### Start/stop
.PHONY: fg
fg:
	@ docker-compose up

.PHONY: up
up: prerequistes
	@ docker-compose up -d

.PHONY: down
down:
	@ docker-compose down

.PHONY: restart
restart: down up


### Tests

# verify performs the tests. It sleeps for a few seconds beforehand to make
# sure that traefik loads the certificates to its store.
.PHONY: verify
verify:
	@ echo "Testing: "
	@ sleep 2
	@ bats tests/verify-certs.bats

# test (re)starts the services, performs verification and stop the services
.PHONY: test
test: restart verify
	@ docker-compose down
