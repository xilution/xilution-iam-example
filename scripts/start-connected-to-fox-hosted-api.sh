#!/usr/bin/env bash

set -e

source .env

if [[ -z "${XILUTION_ENVIRONMENT}" ]]; then
  echo "XILUTION_ENVIRONMENT not found in .env"
  exit 1
fi

if [[ -z "${XILUTION_SUB_ORGANIZATION_ID}" ]]; then
  echo "XILUTION_SUB_ORGANIZATION_ID not found in .env"
  exit 1
fi

if [[ -z "${XILUTION_WEB_CLIENT_ID}" ]]; then
  echo "XILUTION_WEB_CLIENT_ID not found in .env"
  exit 1
fi

if [[ -z "${XILUTION_INSTANCE_ID}" ]]; then
  echo "XILUTION_INSTANCE_ID not found in .env"
  exit 1
fi

webpack-dev-server \
  --env.XILUTION_ENVIRONMENT="${XILUTION_ENVIRONMENT}" \
  --env.XILUTION_SUB_ORGANIZATION_ID="${XILUTION_SUB_ORGANIZATION_ID}" \
  --env.XILUTION_WEB_CLIENT_ID="${XILUTION_WEB_CLIENT_ID}" \
  --env.API_BASE_URL="https://${XILUTION_INSTANCE_ID}.${XILUTION_ENVIRONMENT}.fox.integration.xilution.com" \
  --config ./webpack.config.js \
  --port 3124
