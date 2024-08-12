#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

#
# Check that a valid license is available
#
./validate.sh
if [ $? -ne 0 ]; then
  exit 1
fi

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
# Run the Docker compose deployment for this scenario
#
cd "deployments/$DEPLOYMENT"
docker compose --project-name spa down 2>/dev/null
docker compose --profile $OAUTH_PROXY_TYPE --project-name spa up --detach
if [ $? -ne 0 ]; then
  echo 'Problem encountered running the Docker deployment'
  exit 1
fi
