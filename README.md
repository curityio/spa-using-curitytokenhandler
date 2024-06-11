# SPA using Curity Token Handler

An example SPA showing the code and deployment to use to integrate with the Curity Token Handler.

## Meet Prerequisites

First ensure that these components are installed:

- Node.js 20+
- Docker
- jq

Edit your `/etc/hosts` file and add these entries:

```bash
127.0.0.1 www.product.example bff.product.example login.example.com
```

Download a [trial license](https://developer.curity.io/free-trial) from the developer portal for the tokenhandler application feature.\
Copy the license file into the root folder of this project.

Download the [Kong OAuth Proxy](https://developer.curity.io/release/9.3.0/?proxy=kong) from the developer portal.\
Copy the zip file into the root folder of this project.

## Deploy the System

Two example deployments are provided, to explain the moving parts of the end-to-end solution.

### Scenario 1: SPA uses an External Authorization Server

An instance of Keycloak acts as the external authorization server and issues RS256 JWTs.\
The Curity Token Handler is deployed as a stateless API that issues cookies to the SPA.

```bash
export DEPLOYMENT='external-client'
./build.sh
./deploy.sh
```

After deployment:

- Access the admin UI for the Curity Token Handler at `https://localhost:6749` using `admin / Password1`.
- Access the Keycloak admin UI at `http://login.example.com/admin/master/console/` using `admin / Password1`.
- Access the Keycloak metadata at `http://login.example.com/realms/example/.well-known/openid-configuration`.

### Scenario 1: SPA uses the Curity Identity Server

A single instance of the Curity Identity Server acts as both authorization server and token handler.

```bash
export DEPLOYMENT='internal-client'
./build.sh
./deploy.sh
```

After deployment:

- Access the admin UI for the Curity components at `https://localhost:6749` using `admin / Password1`.

## Use the System

Browse to the SPA at `http://www.product.example` and log in as the pre-shipped account `demouser` / `Password1`.\
Test all OAuth lifecycle operations against a backend for frontend at `http://bff.product.example`. 

## Clean Up

When finished testing, teardown any local Docker-deployed components like this:

```bash
./teardown.sh
```
