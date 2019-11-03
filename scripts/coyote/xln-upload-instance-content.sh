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

if [[ -z "${XILUTION_ACCOUNT_USER_ID}" ]]; then
  echo "XILUTION_ACCOUNT_USER_ID not found in .env"
  exit 1
fi

environment=${XILUTION_ENVIRONMENT}
access_token=${XILUTION_ACCOUNT_ACCESS_TOKEN}
sub_organization_id=${XILUTION_SUB_ORGANIZATION_ID}
bundle_data=$(openssl enc -A -base64 -in bundle.js)
favicon_data=$(openssl enc -A -base64 -in favicon.ico)
index_data=$(openssl enc -A -base64 -in index.html)

curl \
  -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${access_token}" \
  -d "[
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
    },
  ]" \
  "https://${environment}.coyote.content-delivery.api.xilution.com/organizations/${sub_organization_id}/contents"
