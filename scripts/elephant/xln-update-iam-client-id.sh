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

if [[ -z "${XILUTION_IAM_CLIENT_ID}" ]]; then
  echo "XILUTION_IAM_CLIENT_ID not found in .env"
  exit 1
fi

if [[ -z "${XILUTION_ACCOUNT_USER_ID}" ]]; then
  echo "XILUTION_ACCOUNT_USER_ID not found in .env"
  exit 1
fi

environment=${XILUTION_ENVIRONMENT}
access_token=${XILUTION_ACCOUNT_ACCESS_TOKEN}
sub_organization_id=${XILUTION_SUB_ORGANIZATION_ID}
user_id=${XILUTION_ACCOUNT_USER_ID}
iam_client_id=${XILUTION_IAM_CLIENT_ID}

curl -s \
  -X PUT \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${access_token}" \
  -d "{
    \"@type\": \"organization\",
    \"id\": \"${sub_organization_id}\",
    \"name\": \"graphql-backend-example-sub-organization\",
    \"organizationId\": \"${sub_organization_id}\",
    \"owningUserId\": \"${user_id}\",
    \"active\": true,
    \"iamClientId\": \"${iam_client_id}\"
  }" \
  "https://${environment}.elephant.basics.api.xilution.com/organizations/${sub_organization_id}"
