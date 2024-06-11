#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

#
# Prevent accidental check-ins by Curity developers
#
cp ./hooks/pre-commit .git/hooks

#
# Validate input
#
if [ "$DEPLOYMENT" != 'external' ] &&
   [ "$DEPLOYMENT" != 'curity' ]; then
  echo 'The DEPLOYMENT environment variable has not been configured correctly'
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
# Build the API gateway Docker image with plugins
#
cd "./deployments/$DEPLOYMENT/apigateway"
rm -rf resources 2>/dev/null
git clone git@bitbucket.org:curity/token-handler-oauth-proxy.git resources
if [ $? -ne 0 ]; then
  echo 'Problem encountered downloading OAuth proxy files'
  exit 1
fi

cd resources
git checkout main
cd ..

docker build -t apigateway:1.0.0 .
if [ $? -ne 0 ]; then
  echo "Problem encountered building the API gateway Docker image"
  exit 1
fi
