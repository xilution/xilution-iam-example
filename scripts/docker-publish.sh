#!/usr/bin/env sh

set -e

if [ $# -lt 1 ]; then
  echo "Usage: yarn docker:publish {docker_hub_account}"
  exit 1
fi

docker_hub_account=${1}

echo "Please enter your Docker Hub account password to publish xilution-iam-example."
docker login -u "${docker_hub_account}"
docker tag xilution-iam-example "${docker_hub_account}"/xilution-iam-example
docker push "${docker_hub_account}"/xilution-iam-example
