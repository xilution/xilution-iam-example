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

curl -s \
  -X GET \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${access_token}" \
  "https://${environment}.coyote.content-delivery.api.xilution.com/organizations/${sub_organization_id}/instances/${coyote_instance_id}/contents?page-size=10" |
  jq "."

echo "${response}"
