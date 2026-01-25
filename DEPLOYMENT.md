# SPA using Curity Token Handler

An example SPA demonstrating the code and deployment to integrate with token handler components.

## Meet Prerequisites

The example deployment requires the following components:

- Node.js 22+
- Docker
- jq
- OpenSSL 3
- Linux command line tools: envsubst and awk

Edit your `/etc/hosts` file and add these entries:

```bash
127.0.0.1 www.product.example bff.product.example login.example.com
```

Use the [Curity developer portal](https://developer.curity.io/releases/token-handler) to download one of the OAuth Proxy zip files to the root folder of this project:

- [Kong OAuth Proxy 2.0.0+](https://developer.curity.io/releases/token-handler?proxy=kong)
- [OpenResty OAuth Proxy 2.0.1+](https://developer.curity.io/releases/token-handler?proxy=openresty)
- [NGINX OAuth Proxy 2.0.0+](https://developer.curity.io/releases/token-handler?proxy=nginx)

## Deploy the System

Two example deployments are provided, to explain the moving parts of the end-to-end solution.

### Scenario 1: SPA uses an External Authorization Server

Download a [Trial License](https://developer.curity.io/free-trial) from the developer portal with access to the `applications` feature.\
Rename the file to `license.json` and copy it into the root folder of this project.

An instance of Keycloak acts as the external authorization server that issues RS256 JWTs as access tokens.\
The OAuth Agent is deployed as a stateless API that issues cookies to the SPA.\
Choose an OAuth proxy type of `kong`, `openresty` or `nginx`:

```bash
export DEPLOYMENT='external'
export OAUTH_PROXY_TYPE='kong'
./build.sh
./deploy.sh
```

Wait a few minutes for components to come up and then access components:

- Curity Token Handler admin UI: `https://localhost:6749/admin` using `admin / Password1`.
- Keycloak admin UI: `http://login.example.com/admin/master/console/` using `admin / Password1`.
- Keycloak metadata: `http://login.example.com/realms/example/.well-known/openid-configuration`.

### Scenario 2: SPA uses the Curity Identity Server as the Authorization Server

Download a [Trial License](https://developer.curity.io/free-trial) from the developer portal with access to the following features.\
Rename the file to `license.json` and copy it into the root folder of this project.

- applications
- financial-grade

The Curity Identity Server deployment demonstrates the following additional features.

- Opaque access tokens that help to ensure small cookies.
- JWT client assertions as an OAuth client credential.
- Pushed authorization requests (PAR).
- JWT Secured Authorization Response Mode (JARM).

A single instance of the Docker deployment acts as both authorization server and OAuth Agent.\
Choose an OAuth proxy type of `kong`, `openresty` or `nginx`:

```bash
export DEPLOYMENT='curity'
export OAUTH_PROXY_TYPE='kong'
./build.sh
./deploy.sh
```

Wait a few minutes for components to come up and then access components:

- Curity admin UI: `https://localhost:6749` using `admin / Password1`.

## Use the System

Browse to the SPA at `http://www.product.example`.\
Log in as the pre-shipped account `demouser` / `Password1`.\
Test all OAuth lifecycle operations against token handler components running at `http://bff.product.example`. 

## Adapt the Deployment

Once you understand the deployment you can adapt and redeploy in various ways:

- [Run in Development Mode](https://curity.io/resources/learn/token-handler-deployment-example/#spa-developer-setup) to understand the pure SPA developer experience.
- [Change Domain Names](https://curity.io/resources/learn/token-handler-deployment-example/#change-external-urls) and [Upgrade to HTTPS URLs](https://curity.io/resources/learn/token-handler-deployment-example/#https-setup) to rehearse real deployments.

## Clean Up

When finished testing, teardown any local Docker-deployed components like this:

```bash
./teardown.sh
```
