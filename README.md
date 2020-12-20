# Reverse proxy behind firewall

This repository is meant to be used as a heroku app.


Supervisor monitors two processes: nginx and a chisel server.

`nginx` faces heroku and listens to whatever `PORT` heroku specifies (as an env variable). 
It forwards all requests to a service that would be listening at `127.0.0.1:8125`. The
only exception is the `/.chisel` endpoint that is forwarded to `127.0.0.1:8124`.

A `chisel` server listens on `localhost:8124` allowing for reverse port mapping. It requires
`AUTH` and `CHISEL_KEY` environment variables to be set.


Let's say you have a server running at home, in your LAN. For instance on a raspberry pi
listening at `192.168.0.34:8800`.


```
CHISEL_SERVER="https://your-heroku-app.com/.chisel"
CHISEL_USER=
CHISEL_PASSWORD=
FINGERPRINT=

MAX_RETRY_COUNT=30
KEEPALIVE="30s"
CHISEL_R_HOST=127.0.0.1
CHISEL_R_PORT=8124
chisel client \
   --fingerprint "${FINGERPRINT}" \
   --auth "${CHISEL_USER}:${CHISEL_PASSWORD}" \
   --keepalive "${KEEPALIVE}" \
   --max-retry-count "${MAX_RETRY_COUNT}" \
   "${CHISEL_SERVER}" \
       "R:${CHISEL_R_HOST}:${CHISEL_R_PORT}:192.168.0.34:8800"
```




## Submitting to heroku:

Build the docker image and push it:

    heroku container:push web

Deploy:

    heroku container:release web

Logs:

    heroku logs --tail

