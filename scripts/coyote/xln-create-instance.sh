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
user_id=${XILUTION_ACCOUNT_USER_ID}

post_response=$(curl -sSL -D - \
  -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${access_token}" \
  -d "{
    \"@type\": \"instance\",
    \"name\": \"xilution-web-frontend-example\",
    \"organizationId\": \"${sub_organization_id}\",
    \"owningUserId\": \"${user_id}\",
    \"stack\": \"SMALL_STACK\"
  }" \
  "https://${environment}.coyote.content-delivery.api.xilution.com/organizations/${sub_organization_id}/instances" \
  -o /dev/null)

url=$(echo "${post_response}" | awk '/^location:/ {print $2;}')
url=${url%$'\r'}

get_response=$(curl -s \
  -X GET \
  -H "Authorization: Bearer ${access_token}" \
  "${url}")

echo "${get_response}" | jq "{coyote_instance_id: .id, instance_name: .name}"

coyote_instance_id=$(echo "${get_response}" | jq -r ".id")

update_environment_variable XILUTION_COYOTE_INSTANCE_ID "${coyote_instance_id}"

echo "All Done! Wrote env variables to .env."
