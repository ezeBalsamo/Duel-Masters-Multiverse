#!/usr/bin/env bash

DOCKER_IMAGE_VERSION=$(echo "$RDBMS" | cut --complement -c -11)
readonly DOCKER_IMAGE_VERSION
docker run -d -p 127.0.0.1:5432:5432 \
  -e POSTGRES_PASSWORD=secret \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_DB=test \
  postgres:"$DOCKER_IMAGE_VERSION"
