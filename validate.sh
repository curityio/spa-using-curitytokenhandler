#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

#
# A utility to decode a JWT payload
#
base64url_decode() {
  local len=$((${#1} % 4))
  local result="$1"
  if [ $len -eq 2 ]; then result="$1"'=='
  elif [ $len -eq 3 ]; then result="$1"'=' 
  fi
  echo "$result" | tr '_-' '/+' | base64 --decode
}

#
# Get a license for the Curity Identity Server
#
if [ ! -f './license.json' ]; then
  echo 'Please copy a license.json file into the root folder'
  exit 1
fi

#
# Do some license validation to prevent cryptic problems later
#
LICENSE_DATA=$(cat './license.json')
LICENSE_JWT=$(echo $LICENSE_DATA | jq -r .License)
LICENSE_PAYLOAD=$(base64url_decode $(echo $LICENSE_JWT | cut -d '.' -f 2))
APPLICATIONS_FEATURE=$(echo $LICENSE_PAYLOAD | jq -r '.Features[]  | select(.feature == "applications")')
if [ "$APPLICATIONS_FEATURE" == '' ]; then
  echo 'The license.json file does not include the applications feature'
  exit 1
fi
