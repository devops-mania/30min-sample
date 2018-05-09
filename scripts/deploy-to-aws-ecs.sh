docker build . -t test

awsAccountId=$(aws sts get-caller-identity | sed s/\"/\\n/g | grep "^[0-9]*$")

imageVersion=travis-${TRAVIS_BUILD_NUMBER}-${TRAVIS_COMMIT}
imageName=${awsAccountId}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${ECS_REPO}:${imageVersion}

$(aws ecr get-login --region $AWS_DEFAULT_REGION --no-include-email)

docker tag test:latest "$imageName"
docker push "$imageName"

task=$(printf '[{
  "name": "30min-sample-container",
  "image": "%s",
  "essential": true,
  "memory": 300,
  "cpu": 10,
  "portMappings": [
    { "hostPort": 80, "protocol": "tcp", "containerPort": 3000 }
  ]
}]' $imageName)

taskDefResponse=$(aws ecs register-task-definition --container-definitions "$task" --family "30min-sample-task")
taskArn=$(echo $taskDefResponse | sed s/\"/\\n/g | grep ^arn:aws:ecs:)
aws ecs update-service --cluster $ECS_CLUSTER --service $ECS_SERVICE --task-definition $taskArn
