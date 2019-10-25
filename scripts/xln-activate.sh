#!/usr/bin/env sh

set -e

if [ $# -lt 1 ]; then
  echo "Usage: yarn xln:activate-coyote {environment}"
  exit 1
fi

environment=${1}

xln-cli api core account_management activate_product \
  --product_id c3d91f28476048d38a7259a9eddd1025 \
  -p "${environment}" | jq '.effective'
