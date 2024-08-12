#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

rm -rf cookie-encryption 2>/dev/null
mkdir cookie-encryption
cd cookie-encryption

#
# The session cookie is encrypted using the system's symmetric key
#
echo 'Creating keys for cookie encryption ...'
export SYMMETRIC_KEY=$(openssl rand 32 | xxd -p -c 64)

#
# Generate proxy cookie keys
#
export TH_COOKIE_KEY_PASS='Password1'
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
# Get the proxy private key into a single line format to supply to API gateways
#
export TH_COOKIE_KEY="$(awk 'NF {sub(/\r/, ""); printf "%s\\n",$0;}' ./cookie-encryption/private-key.pkcs8)"
if [ $? -ne 0 ]; then
  echo 'Problem encountered producing the TH_COOKIE_KEY parameter'
  exit 1
fi

#
# Get the proxy public key into a single line format recognized by the Curity Identity Server
#
export TH_COOKIE_CERT="$(openssl base64 -in ./cookie-encryption/public-key.pem | tr -d '\n')"
if [ $? -ne 0 ]; then
  echo 'Problem encountered producing the TH_COOKIE_CERT parameter'
  exit 1
fi

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

#
# Indicate success
#
echo 'Cookie encryption keys configured successfully ...'
