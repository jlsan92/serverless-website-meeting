#!/usr/bin/env bash

set -o errexit
set -o pipefail

AWS_PROFILE=${AWS_PROFILE:-"serverless"}

[ ${TRAVIS_PULL_REQUEST} ] || { echo "Not a feature branch. Čus! 👋"; exit 0; }

echo "Deploying ${TRAVIS_PULL_REQUEST_BRANCH} ⬆️"

docker run \
  --rm \
  --volume "${HOME}/.aws":/root/.aws \
  --volume "$(pwd):/project" \
  --env AWS_PROFILE="${AWS_PROFILE}" \
  mesosphere/aws-cli \
  s3 sync --delete ./build "s3://serverless-features.strv.com/${TRAVIS_PULL_REQUEST_BRANCH}/"
