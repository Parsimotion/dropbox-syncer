# dropbox-syncer
[![Build 
Status](https://semaphoreci.com/api/v1/projects/2e23c247-6e78-4544-8cff-4a9e7ff56ed4/484350/badge.svg)](https://semaphoreci.com/andreskir/dropbox-syncer)

## Setup

```bash
#(instalar mongodb-org)

npm install
bower install
bundle install
```

Crear `/server/config/local.env.coffee` con:
```coffee
"use strict"

# Use local.env.js for environment variables that grunt will set when the server starts locally.
# Use for your api keys, secrets, etc. This file should not be tracked by git.
#
# You will need to set these on the server you deploy to.
module.exports =
 DOMAIN: "http://localhost:9000"
 SESSION_SECRET: "***"
 VARIABLE: "***"

 # Control debug level for modules using visionmedia/debug
 DEBUG: ""
```

Los valores de estos atributos son secretos, por eso este archivo se encuentra ignorado en el versionado.

## Servidor

```bash
grunt serve
```

## Tests

```bash
grunt test:client
grunt test:server
```
