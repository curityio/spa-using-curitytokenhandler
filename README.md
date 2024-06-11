# SPA using Curity Token Handler

An example SPA showing the code and deployment to use to integrate with the Curity Token Handler.

## Prerequisites

First ensure that these components are installed:

- Node.js 20+
- Docker
- jq

Edit your `/etc/hosts` file and add these entries:

```bash
127.0.0.1 www.product.example bff.product.example login.example.com
```

Download a `license.json` file from the Curity developer portal, with rights to the tokenhandler application feature.\
Copy the license file into the root folder of this project.

Download the [Kong OAuth Proxy](https://developer.curity.io/release/9.3.0/?proxy=kong) from the Curity Developer Portal and copy its zip file into the root folder.

## Deploy the System

Two example deployments are provided, to explain the moving parts of the end-to-end solution.

### External Client

An instance of Keycloak acts as the external authorization server and issues RS256 JWTs.\
After deployment, access its admin UI at `http://login.example.com/admin/master/console/` using `admin / Password1`.\
Or access the metadata endpoint at `http://login.example.com/realms/example/.well-known/openid-configuration`.

The OAuth Agent is deployed as a separate Curity docker instance that runs only the application profile.\
This is a stateless component that does not require a data store, with an admin UI at `https://localhost:6749`.

```bash
export DEPLOYMENT='external-client'
./build.sh
./deploy.sh
```

### Internal Client

A single instance of the Curity Identity Server acts as both authorization server and token handler.

```bash
export DEPLOYMENT='internal-client'
./build.sh
./deploy.sh
```

## Use the System

After deployment, browse to `http://www.product.example` to log in and test OAuth lifecycle operations.\
Use a preshipped user account of `demouser` / `Password1`.\
The token handler components are deployed to a sibling domain and run from `http://bff.product.example`. 

## Clean Up

When finished testing, teardown any local Docker-deployed components like this:

```bash
./teardown.sh
```
