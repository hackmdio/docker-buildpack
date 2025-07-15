#!/usr/bin/env bash

set -euo pipefail

DOCKER_IMAGE_NAME="$1"
DOCKER_IMAGE_TAG_PREFIX="$2"

SHA1="$(git rev-parse HEAD)"
SHORT_ID="${SHA1:0:8}"

MANIFEST_TAG="hackmdio/$DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG_PREFIX-$SHORT_ID"
AMD64_TAG="hackmdio/$DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG_PREFIX-$SHORT_ID-amd64"
ARM64_TAG="hackmdio/$DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG_PREFIX-$SHORT_ID-arm64"

echo "Creating multi-arch manifest $MANIFEST_TAG"

# Create and push multi-arch manifest
docker manifest create "$MANIFEST_TAG" "$AMD64_TAG" "$ARM64_TAG"
docker manifest annotate "$MANIFEST_TAG" "$AMD64_TAG" --arch amd64
docker manifest annotate "$MANIFEST_TAG" "$ARM64_TAG" --arch arm64
docker manifest push "$MANIFEST_TAG"

echo "Successfully created and pushed multi-arch manifest $MANIFEST_TAG" 