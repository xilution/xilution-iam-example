#!/usr/bin/env sh

set -e

if [ $# -lt 4 ]; then
  echo "Usage: yarn xln:upload-instance-content {environment} {organization_id} {instance_id} {input_folder}"
  exit 1
fi

environment=${1}
organization_id=${2}
instance_id=${3}
input_folder=${4}

xln-cli api content_delivery coyote upload_instance_content \
  --organization_id "${organization_id}" \
  --instance_id "${instance_id}" \
  --input_folder "${input_folder}" \
  -p "${environment}"
