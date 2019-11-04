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

if [[ -z "${XILUTION_IAM_USER_ID}" ]]; then
  echo "XILUTION_IAM_USER_ID not found in .env"
  exit 1
fi

if [[ -z "${XILUTION_WEB_CLIENT_ID}" ]]; then
  echo "XILUTION_WEB_CLIENT_ID not found in .env"
  exit 1
fi

if [[ -z "${XILUTION_COYOTE_INSTANCE_ID}" ]]; then
  echo "XILUTION_COYOTE_INSTANCE_ID not found in .env"
  exit 1
fi

environment=${XILUTION_ENVIRONMENT}
access_token=${XILUTION_ACCOUNT_ACCESS_TOKEN}
sub_organization_id=${XILUTION_SUB_ORGANIZATION_ID}
account_user_id=${XILUTION_ACCOUNT_USER_ID}
iam_user_id=${XILUTION_IAM_USER_ID}
web_client_id=${XILUTION_WEB_CLIENT_ID}
coyote_instance_id=${XILUTION_COYOTE_INSTANCE_ID}

response=$(curl -s \
  -X PUT \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${access_token}" \
  -d "{
    \"@type\": \"client\",
    \"id\": \"${web_client_id}\",
    \"name\": \"web-frontend-example-web-client\",
    \"grants\": [
      \"authorization_code\",
      \"refresh_token\"
    ],
    \"redirectUris\": [
      \"http://localhost:3124/#/pets\",
      \"http://localhost:3124/\",
      \"https://${coyote_instance_id}.${environment}.coyote.content-delivery.xilution.com/#/pets\",
      \"https://${coyote_instance_id}.${environment}.coyote.content-delivery.xilution.com/\"
    ],
    \"organizationId\": \"${sub_organization_id}\",
    \"clientUserId\": \"${iam_user_id}\",
    \"owningUserId\": \"${account_user_id}\",
    \"active\": true
  }" \
  "https://${environment}.hippo.basics.api.xilution.com/organizations/${sub_organization_id}/clients/${web_client_id}")

echo "${response}"
