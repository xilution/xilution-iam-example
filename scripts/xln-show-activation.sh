#!/usr/bin/env sh

set -e

if [ $# -lt 3 ]; then
  echo "Usage: yarn xln:show-activation {environment}"
  exit 1
fi

environment=${1}

xln-cli api core account_management list_product_activations \
  --page_number=0 \
  --page_size=25 \
  -p "${environment}" | jq '.content | map(select(.id == "c3d91f28476048d38a7259a9eddd1025")) | if (. | length > 0) then .[] .effective else "Coyote is not active." end'
