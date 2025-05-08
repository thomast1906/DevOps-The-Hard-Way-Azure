#!/bin/bash
# build-push-acr.sh
#
# This script automates the process of building a Docker image and pushing it to Azure Container Registry.
# It demonstrates best practices for working with Docker and ACR.
#
# Usage:
#   ./build-push-acr.sh <acr_name> [image_tag]

set -e  # Exit immediately if a command exits with a non-zero status

# Define colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Functions for display
info() {
    echo -e "${GREEN}INFO:${NC} $1"
}

warn() {
    echo -e "${YELLOW}WARNING:${NC} $1"
}

error() {
    echo -e "${RED}ERROR:${NC} $1"
    exit 1
}

# Check for Azure CLI installation
if ! command -v az &> /dev/null; then
    error "Azure CLI could not be found. Please install it first."
fi

# Check for Docker installation
if ! command -v docker &> /dev/null; then
    error "Docker could not be found. Please install it first."
fi

# Check parameters
if [ $# -lt 1 ]; then
    error "Usage: $0 <acr_name> [image_tag]"
fi

ACR_NAME=$1
IMAGE_TAG=${2:-v1}  # Default to v1 if not provided
TIMESTAMP=$(date +%Y%m%d%H%M%S)
IMAGE_REPO="thomasthorntoncloud"
FULL_IMAGE_TAG="$ACR_NAME.azurecr.io/$IMAGE_REPO:$IMAGE_TAG"
LATEST_TAG="$ACR_NAME.azurecr.io/$IMAGE_REPO:latest"

info "Starting Docker build and push to ACR process..."

# Verify ACR exists
info "Verifying ACR '$ACR_NAME' exists..."
az acr show --name "$ACR_NAME" --query name -o tsv 2>/dev/null || error "ACR '$ACR_NAME' does not exist or you don't have access to it."

# Log in to ACR
info "Logging in to ACR '$ACR_NAME'..."
az acr login --name "$ACR_NAME" || error "Failed to log in to ACR."

# Check if we're running on Apple Silicon
if [[ "$(uname -m)" == "arm64" ]]; then
    warn "Detected Apple Silicon (ARM64). Using --platform=linux/amd64 for compatibility."
    PLATFORM_FLAG="--platform=linux/amd64"
else
    PLATFORM_FLAG=""
fi

# Build the Docker image
info "Building Docker image with tag '$FULL_IMAGE_TAG'..."
docker build $PLATFORM_FLAG -t "$FULL_IMAGE_TAG" . || error "Docker build failed."

# Tag with 'latest' as well
info "Tagging image as 'latest'..."
docker tag "$FULL_IMAGE_TAG" "$LATEST_TAG" || error "Failed to tag image as latest."

# Push to ACR
info "Pushing image to ACR..."
docker push "$FULL_IMAGE_TAG" || error "Failed to push image to ACR."
docker push "$LATEST_TAG" || error "Failed to push latest tag to ACR."

# Verify the push
info "Verifying image in ACR..."
az acr repository show-tags --name "$ACR_NAME" --repository "$IMAGE_REPO" -o table || warn "Could not verify image in ACR."

info "Image build and push completed successfully!"
info "Your image is available at: $FULL_IMAGE_TAG"
info "Also available as: $LATEST_TAG"

# Show next steps
echo ""
echo "Next steps:"
echo "1. Update your Kubernetes manifests to use this image"
echo "2. Apply the manifests to your AKS cluster"
echo "3. Verify the deployment"
