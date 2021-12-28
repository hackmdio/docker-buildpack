#!/usr/bin/env bash

set -euo pipefail

SHA1="$(git rev-parse HEAD)"
SHORT_ID="${SHA1:0:8}"

DOCKER_DIR="$1"
DOCKER_IMAGE_NAME="$2"
DOCKER_IMAGE_TAG_PREFIX="$3"
DOCKER_FILE="${4:-Dockerfile}"

docker buildx build --push --platform linux/amd64,linux/arm64 --tag "hackmdio/$DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG_PREFIX-$SHORT_ID" -f "./$DOCKER_DIR/$DOCKER_FILE" .
