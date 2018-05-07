#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

docker build . -t test

awsAccountId=$(aws sts get-caller-identity | sed s/\"/\\n/g | grep "^[0-9]*$")

imageVersion=travis-${TRAVIS_BUILD_NUMBER}-${TRAVIS_COMMIT}
imageName=${awsAccountId}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${ECS_REPO}:${imageVersion}

$(aws ecr get-login --region $AWS_DEFAULT_REGION --no-include-email)

docker tag test:latest "$imageName"
docker push "$imageName"
