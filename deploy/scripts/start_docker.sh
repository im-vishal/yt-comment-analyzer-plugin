#!/bin/bash
# Log everything to start_docker.log
exec > /home/ubuntu/start_docker.log 2>&1

echo "Logging in to ECR..."
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 823558662715.dkr.ecr.ap-south-1.amazonaws.com

echo "Pulling Docker image..."
docker pull 823558662715.dkr.ecr.ap-south-1.amazonaws.com/yt-chrome-plugin:latest

echo "Checking for existing container..."
if [ "$(docker ps -q -f name=yt-app)" ]; then
    echo "Stopping existing container..."
    docker stop yt-app
fi

if [ "$(docker ps -aq -f name=yt-app)" ]; then
    echo "Removing existing container..."
    docker rm yt-app
fi

echo "Starting new container..."
docker run -d -p 80:5000 -e DAGSHUB_PAT=c52d45d06347759d028fabbb3cc57e53cf6d5a33 --name yt-app 823558662715.dkr.ecr.ap-south-1.amazonaws.com/yt-chrome-plugin:latest

echo "Container started successfully."