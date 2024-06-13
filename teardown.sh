#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

#
# Tear down deployed components
#
docker compose --project-name spa down
