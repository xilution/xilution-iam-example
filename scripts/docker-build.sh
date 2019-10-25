#!/usr/bin/env sh

set -e

if [ $# -lt 4 ]; then
  echo "Usage: yarn docker:build {environment} {organization_id} {client_id} {instance_id}"
  exit 1
fi

environment=${1}
organization_id=${2}
client_id=${3}
instance_id=${4}

docker build \
  --build-arg XILUTION_ENVIRONMENT="${environment}" \
  --build-arg XILUTION_ORGANIZATION_ID="${organization_id}" \
  --build-arg XILUTION_CLIENT_ID="${client_id}" \
  --build-arg XILUTION_INSTANCE_ID="${instance_id}" \
  -t xilution-iam-example \
  -f docker/Dockerfile .
