#!/usr/bin/env bash

set -o errexit
set -o pipefail

CURRENT_BRANCH=${TRAVIS_BRANCH:-"$(git symbolic-ref --short HEAD)"}

# Ref: https://github.com/facebook/create-react-app/blob/master/packages/react-scripts/template/README.md#advanced-configuration
export PUBLIC_URL=$([[ ! -z ${TRAVIS_PULL_REQUEST_BRANCH} ]] && echo ${FEATURES_HOSTNAME}/${TRAVIS_PULL_REQUEST_BRANCH} || echo "")

echo "Building app 🔨"

npx react-scripts build
