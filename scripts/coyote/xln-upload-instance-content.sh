#!/usr/bin/env bash

set -e

. ./scripts/common-functions.sh

source .env

if [[ -z "${XILUTION_ENVIRONMENT}" ]]; then
  echo "XILUTION_ENVIRONMENT not found in .env"
  exit 1
fi

if [[ -z "${XILUTION_ACCOUNT_ACCESS_TOKEN}" ]]; then
  echo "XILUTION_ACCOUNT_ACCESS_TOKEN not found in .env"
  exit 1
fi

if [[ -z "${XILUTION_SUB_ORGANIZATION_ID}" ]]; then
  echo "XILUTION_SUB_ORGANIZATION_ID not found in .env"
  exit 1
fi

if [[ -z "${XILUTION_COYOTE_INSTANCE_ID}" ]]; then
  echo "XILUTION_COYOTE_INSTANCE_ID not found in .env"
  exit 1
fi

environment=${XILUTION_ENVIRONMENT}
access_token=${XILUTION_ACCOUNT_ACCESS_TOKEN}
sub_organization_id=${XILUTION_SUB_ORGANIZATION_ID}
coyote_instance_id=${XILUTION_COYOTE_INSTANCE_ID}
bundle_data=$(openssl enc -A -base64 -in ./dist/bundle.js)
favicon_data=$(openssl enc -A -base64 -in ./dist/favicon.ico)
index_data=$(openssl enc -A -base64 -in ./dist/index.html)

echo "[
  {
    \"data\": \"${bundle_data}\",
    \"key\": \"bundle.js\",
    \"type\": \"text/javascript\"
  },
  {
    \"data\": \"${favicon_data}\",
    \"key\": \"favicon.ico\",
    \"type\": \"image/vnd.microsoft.icon\"
  },
  {
    \"data\": \"${index_data}\",
    \"key\": \"index.html\",
    \"type\": \"text/html\"
  }
]" > ./temp.json

response=$(curl \
  -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${access_token}" \
  -d @temp.json \
  "https://${environment}.coyote.content-delivery.api.xilution.com/organizations/${sub_organization_id}/instances/${coyote_instance_id}/contents")

echo "${response}"

rm -rf ./temp.json
