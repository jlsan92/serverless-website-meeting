#!/usr/bin/env bash

set -o errexit
set -o pipefail

AWS_PROFILE=${AWS_PROFILE:-"serverless"}

echo "Deploying to production!"

docker run \
  --rm \
  --volume "${HOME}/.aws":/root/.aws \
  --volume "$(pwd):/project" \
  --env AWS_PROFILE="${AWS_PROFILE}" \
  mesosphere/aws-cli s3 sync --delete ./build "s3://serverless.strv.com/"

docker run \
  --rm \
  --volume "${HOME}/.aws":/root/.aws \
  --env AWS_PROFILE="${AWS_PROFILE}" \
  mesosphere/aws-cli cloudfront create-invalidation --distribution-id ${CLOUDFRONT_DISTRO} --paths '/*'
