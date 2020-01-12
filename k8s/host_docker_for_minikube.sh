#! /bin/bash

set -e

eval $(minikube docker-env)

docker build -t front-example ../front/
docker build -t back-example ../back/
