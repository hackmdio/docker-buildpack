#!/usr/bin/env bash

set -euo pipefail

DOCKER_DIR="$1"
DOCKER_IMAGE_NAME="$2"
DOCKER_IMAGE_TAG_PREFIX="$3"
PLATFORM="$4"
DOCKER_FILE="${5:-Dockerfile}"

SHA1="$(git rev-parse HEAD)"
SHORT_ID="${SHA1:0:8}"

# Convert platform format (linux/amd64 -> amd64, linux/arm64 -> arm64)
ARCH=$(echo "$PLATFORM" | cut -d'/' -f2)

# Build and push platform-specific image
PLATFORM_TAG="hackmdio/$DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG_PREFIX-$SHORT_ID-$ARCH"
echo "Building $PLATFORM_TAG for platform $PLATFORM"

docker build --platform "$PLATFORM" --tag "$PLATFORM_TAG" -f "./$DOCKER_DIR/$DOCKER_FILE" .
docker push "$PLATFORM_TAG"

echo "Successfully built and pushed $PLATFORM_TAG" 