#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

#
# Prevent accidental check-ins by Curity developers
#
cp ./hooks/pre-commit .git/hooks

#
# Validate input
#
if [ "$DEPLOYMENT" != 'external' ] && [ "$DEPLOYMENT" != 'curity' ]; then
  echo 'The DEPLOYMENT environment variable has not been configured correctly'
  exit 1
fi

if [ "$OAUTH_PROXY_TYPE" != 'kong' ] && [ "$OAUTH_PROXY_TYPE" != 'openresty' ]; then
  echo 'The OAUTH_PROXY_TYPE environment variable has not been configured correctly'
  exit 1
fi

#
# Check that the Kong gateway plugin ZIP file is available
#
if [ ! -f token-handler-proxy-$OAUTH_PROXY_TYPE*.zip ]; then
  echo 'Please download a gateway plugin to the root folder before building'
  exit 1
fi

#
# Do a release build of the SPA
#
cd spa
npm install
if [ $? -ne 0 ]; then
  echo 'Problem encountered installing the SPA dependencies'
  exit 1
fi

npm run build
if [ $? -ne 0 ]; then
  echo 'Problem encountered building the SPA release code'
  exit 1
fi
cd ..

#
# Prepare the example web host
#

cd webhost
npm install
if [ $? -ne 0 ]; then
  echo 'Problem encountered installing the web host dependencies'
  exit 1
fi

npm run build
if [ $? -ne 0 ]; then
  echo 'Problem encountered building the web host'
  exit 1
fi

cd ..
docker build -f webhost/Dockerfile -t webhost:1.0.0 .
if [ $? -ne 0 ]; then
  echo 'Problem encountered building the web host Docker image'
  exit 1
fi

#
# Prepare the Example API that handles JWT access tokens
#
cd api
npm install
if [ $? -ne 0 ]; then
  echo 'Problem encountered installing the example API dependencies'
  exit 1
fi

npm run build
if [ $? -ne 0 ]; then
  echo 'Problem encountered building the example API code'
  exit 1
fi

docker build -f Dockerfile -t example-api:1.0.0 .
if [ $? -ne 0 ]; then
  echo 'Problem encountered building the example API Docker image'
  exit 1
fi
cd ..

#
# Unpack the Kong OAuth Proxy Plugin and deploy it in a custom API gateway Docker image
#
cd "./deployments/$DEPLOYMENT/apigateway"
rm -rf resources 2>/dev/null

unzip ../../../token-handler-proxy-$OAUTH_PROXY_TYPE*.zip -d ./resources
if [ $? -ne 0 ]; then
  echo 'Problem encountered unzipping the OAuth proxy files'
  exit 1
fi

if [ "$OAUTH_PROXY_TYPE" == 'openresty' ]; then
  docker build -f openresty/Dockerfile -t apigateway-openresty:1.0.0 .
else
  docker build -f kong/Dockerfile -t apigateway-kong:1.0.0 .
fi
if [ $? -ne 0 ]; then
  echo "Problem encountered building the API gateway Docker image"
  exit 1
fi
