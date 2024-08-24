#
# Builds a Docker image.
#
# Environment variables:
#
#   CONTAINER_REGISTRY - The hostname of your container registry.
#   VERSION - The version number to tag the images with.
#
# Usage:
#
#       ./scripts/build-image.sh
#

set -u # or set -o nounset
: "$CONTAINER_REGISTRY"
: "$VERSION"


# Enable Docker Buildx for multi-platform builds
docker buildx create --use

# Build and push the Docker image for both ARM and x86_64 platforms
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t "$CONTAINER_REGISTRY/video-streaming:$VERSION" \
  --file ./Dockerfile-prod \