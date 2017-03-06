#!/bin/bash
docker build -t kineticcookie/sample-node .
docker push kineticcookie/sample-node

ssh deploy@35.187.18.155 << EOF
docker pull kineticcookie/sample-node:latest
docker stop web || true
docker rm web || true
docker rmi kineticcookie/sample-node:current || true
docker tag kineticcookie/sample-node:latest kineticcookie/sample-node:current
docker run -d --net app --restart always --name web -p 80:80 kineticcookie/sample-node:current
EOF
