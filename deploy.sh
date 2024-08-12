#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

#
# Check that a valid license is available
#
./validate-license.sh
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
# Generate keys for cookie encryption
#
export TH_COOKIE_KEY_PASS='Password1'
echo 'Creating keys for cookie encryption ...'
rm -rf cookie-encryption 2>/dev/null
mkdir cookie-encryption
cd cookie-encryption
openssl ecparam -name prime256v1 -genkey -noout -out private-key.pem
openssl ec -in private-key.pem -pubout -out public-key.pem
openssl pkcs8 -topk8 -in private-key.pem -out private-key.pkcs8 -passout pass:"$TH_COOKIE_KEY_PASS"
rm private-key.pem
if [ $? -ne 0 ]; then
  echo 'Problem encountered generating cookie encryption keys'
  exit 1
fi
cd ..

#
# Get the protected private key and the public key into environment variables
#
export TH_COOKIE_KEY="\"$(awk 'NF {sub(/\r/, ""); printf "%s\\n",$0;}' ./cookie-encryption/private-key.pkcs8)\""
if [ $? -ne 0 ]; then
  echo 'Problem encountered producing the TH_COOKIE_KEY parameter'
  exit 1
fi
export TH_COOKIE_CERT="$(openssl base64 -in ./cookie-encryption/public-key.pem | tr -d '\n')"
if [ $? -ne 0 ]; then
  echo 'Problem encountered producing the TH_COOKIE_CERT parameter'
  exit 1
fi
echo 'Cookie encryption keys created successfully ...'

#
# Finalize the SPA's API gateway routes
#
cd ./deployments/$DEPLOYMENT/apigateway
if [ "$OAUTH_PROXY_TYPE" == 'openresty' ]; then
  envsubst < ./openresty/default.conf.template > ./openresty/default.conf
else
  envsubst < ./kong/kong.yml.template > ./kong/kong.yml
fi
if [ $? -ne 0 ]; then
  echo 'Problem encountered updating API gateway configuration with cookie encryption keys'
  exit 1
fi
cd ../../..
echo 'API gateway cookie keys updated successfully ...'

#
# Run the Docker compose deployment for this scenario
#
echo 'Deploying the docker compose system ...'
cd "deployments/$DEPLOYMENT"
docker compose --project-name spa down 2>/dev/null
docker compose --profile $OAUTH_PROXY_TYPE --project-name spa up --detach
if [ $? -ne 0 ]; then
  echo 'Problem encountered running the Docker deployment'
  exit 1
fi
