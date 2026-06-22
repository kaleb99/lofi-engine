#!/usr/bin/env bash
# push-to-registry.sh — tag and push the lofi-engine image to a local registry
#
# Usage:
#   ./push-to-registry.sh <registry-host:port>
#   ./push-to-registry.sh --local
#
# Example:
#   ./push-to-registry.sh daedalus.local:9003
#   ./push-to-registry.sh --local
set -euo pipefail

IMAGE_NAME="lofi-engine"
IMAGE_TAG="latest"
LOCAL_REGISTRY_PORT=9003

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <registry-host:port>"
  echo "       $0 --local"
  echo "  e.g. $0 daedalus.local:9003"
  exit 1
fi

if [[ "$1" == "--local" ]]; then
  REGISTRY="$(hostname | tr '[:upper:]' '[:lower:]').local:$LOCAL_REGISTRY_PORT"
else
  REGISTRY="$1"
fi

TARGET="$REGISTRY/$IMAGE_NAME:$IMAGE_TAG"

echo "Tagging $IMAGE_NAME:$IMAGE_TAG as $TARGET..."
docker tag "$IMAGE_NAME:$IMAGE_TAG" "$TARGET"

echo "Pushing $TARGET..."
docker push "$TARGET"

echo "Done. Pulled via: docker pull $TARGET"
