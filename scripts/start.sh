#!/usr/bin/env sh

set -e

if [ $# -lt 4 ]; then
  echo "Usage: yarn start {environment} {organization_id} {client_id} {instance_id}"
  exit 1
fi

environment=${1}
organization_id=${2}
client_id=${3}
instance_id=${4}

webpack-dev-server \
  --env.XILUTION_ENVIRONMENT="${environment}" \
  --env.XILUTION_ORGANIZATION_ID="${organization_id}" \
  --env.XILUTION_CLIENT_ID="${client_id}" \
  --env.XILUTION_INSTANCE_ID="${instance_id}" \
  --config ./webpack.config.js \
  --port 3000
