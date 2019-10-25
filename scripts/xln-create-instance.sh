#!/usr/bin/env sh

set -e

if [ $# -lt 6 ]; then
  echo "Usage: yarn xln:create-coyote-instance {environment} {organization_id} {owning_user_id}"
  exit 1
fi

environment=${1}
organization_id=${2}
owning_user_id=${3}

echo "{
  \"@type\": \"instance\",
  \"name\": \"xilution-iam-example\",
  \"organizationId\": \"${organization_id}\",
  \"owningUserId\": \"${owning_user_id}\",
  \"stack\": \"SMALL_STACK\"
}" >./xilution-iam-example-temp.json

xln-cli api integration coyote create_instance \
  --organization_id "${organization_id}" \
  --input_file ./xilution-iam-example-temp.json \
  -p "${environment}" | jq '. | {id: .id, name: .name}'

rm -rf ./xilution-iam-example-temp.json
