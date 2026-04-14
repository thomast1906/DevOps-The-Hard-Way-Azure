#!/bin/bash

# DevOps The Hard Way - Azure - Full Deployment Script
# This script deploys the entire infrastructure and application
# Run from the repository root: ./scripts/deploy-all.sh

set -e  # Exit on any error

# Resolve repo root regardless of where the script is called from
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
PROJECT_NAME="${PROJECT_NAME:-devopsthehardway}"
LOCATION="${LOCATION:-uksouth}"
RESOURCE_GROUP="${PROJECT_NAME}-rg"
TF_RG="${PROJECT_NAME}-terraform-rg"
TF_SA="${PROJECT_NAME}tfstate"
TF_CONTAINER="tfstate"

echo -e "${BLUE}🚀 Starting DevOps The Hard Way - Azure Deployment${NC}"
echo -e "${BLUE}Project: ${PROJECT_NAME}${NC}"
echo -e "${BLUE}Location: ${LOCATION}${NC}"
echo ""

# Function to print step headers
print_step() {
    echo -e "${GREEN}📋 Step $1: $2${NC}"
    echo "----------------------------------------"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check prerequisites
print_step "0" "Checking Prerequisites"
if ! command_exists "az"; then
    echo -e "${RED}❌ Azure CLI not found. Please install it first.${NC}"
    exit 1
fi

if ! command_exists "terraform"; then
    echo -e "${RED}❌ Terraform not found. Please install it first.${NC}"
    exit 1
fi

if ! command_exists "docker"; then
    echo -e "${RED}❌ Docker not found. Please install it first.${NC}"
    exit 1
fi

if ! command_exists "kubectl"; then
    echo -e "${RED}❌ kubectl not found. Please install it first.${NC}"
    exit 1
fi

if ! command_exists "helm"; then
    echo -e "${RED}❌ Helm not found. Please install it first.${NC}"
    exit 1
fi

echo -e "${GREEN}✅ All prerequisites met${NC}"
echo ""

# Check Azure login
print_step "1" "Verifying Azure Authentication"
if ! az account show &> /dev/null; then
    echo -e "${YELLOW}⚠️  Not logged into Azure. Please login first.${NC}"
    az login
fi

SUBSCRIPTION_ID=$(az account show --query id -o tsv)
echo -e "${GREEN}✅ Logged into Azure (Subscription: ${SUBSCRIPTION_ID})${NC}"
echo ""

# Step 2: Create Storage Account for Terraform State
print_step "2" "Creating Terraform Remote State Storage"
cd "$REPO_ROOT/1-Azure"
if [ -f "scripts/1-create-terraform-storage.sh" ]; then
    chmod +x scripts/1-create-terraform-storage.sh
    ./scripts/1-create-terraform-storage.sh
else
    echo -e "${YELLOW}⚠️  Creating storage account manually...${NC}"
    az group create --name "$TF_RG" --location "$LOCATION"
    az storage account create --name "$TF_SA" --resource-group "$TF_RG" --location "$LOCATION" --sku Standard_LRS
    az storage container create --name "$TF_CONTAINER" --account-name "$TF_SA"
fi
echo ""

# Step 3: Create Azure AD Group
print_step "3" "Creating Azure AD Group for AKS Admins"
cd "$REPO_ROOT/1-Azure"
if [ -f "scripts/2-create-azure-ad-group.sh" ]; then
    chmod +x scripts/2-create-azure-ad-group.sh
    ./scripts/2-create-azure-ad-group.sh
else
    echo -e "${YELLOW}⚠️  Creating AD group manually...${NC}"
    GROUP_ID=$(az ad group create --display-name "AKS-Admins-${PROJECT_NAME}" --mail-nickname "aks-admins-${PROJECT_NAME}" --query id -o tsv)
    echo "Created AD Group with ID: $GROUP_ID"
    echo "Please update terraform.tfvars with this group ID"
fi
echo ""

# Helper: run terraform init with dynamic backend config
tf_init() {
    local key="$1"
    terraform init \
        -backend-config="resource_group_name=${TF_RG}" \
        -backend-config="storage_account_name=${TF_SA}" \
        -backend-config="container_name=${TF_CONTAINER}" \
        -backend-config="key=${key}"
}

# Step 4: Deploy Infrastructure with Terraform
print_step "4" "Deploying Azure Container Registry (ACR)"
cd "$REPO_ROOT/2-Terraform-AZURE-Services-Creation/1-acr"
tf_init "acr-terraform.tfstate"
terraform plan -out=tfplan
terraform apply tfplan
echo ""

print_step "5" "Deploying Virtual Network (VNET)"
cd "$REPO_ROOT/2-Terraform-AZURE-Services-Creation/2-vnet"
tf_init "vnet-terraform.tfstate"
terraform plan -out=tfplan
terraform apply tfplan
echo ""

print_step "6" "Deploying Log Analytics Workspace"
cd "$REPO_ROOT/2-Terraform-AZURE-Services-Creation/3-log-analytics"
tf_init "la-terraform.tfstate"
terraform plan -out=tfplan
terraform apply tfplan
echo ""

print_step "7" "Deploying AKS Cluster and IAM Roles"
cd "$REPO_ROOT/2-Terraform-AZURE-Services-Creation/4-aks"
tf_init "aks-terraform.tfstate"
terraform plan -out=tfplan
terraform apply tfplan

# Get AKS credentials
echo -e "${YELLOW}📋 Getting AKS credentials...${NC}"
az aks get-credentials --resource-group "$RESOURCE_GROUP" --name "${PROJECT_NAME}aks" --overwrite-existing --admin
echo ""

# Step 5: Build and Push Docker Image
print_step "8" "Building and Pushing Docker Image"
cd "$REPO_ROOT/3-Docker"

echo -e "${YELLOW}📋 Building Docker image for AMD64 platform...${NC}"
docker build --platform linux/amd64 -t "${PROJECT_NAME}azurecr.azurecr.io/thomasthorntoncloud:v2" .

echo -e "${YELLOW}📋 Logging into ACR...${NC}"
az acr login --name "${PROJECT_NAME}azurecr"

echo -e "${YELLOW}📋 Pushing image to ACR...${NC}"
docker push "${PROJECT_NAME}azurecr.azurecr.io/thomasthorntoncloud:v2"
echo ""

# Step 6: Deploy Kubernetes Resources
print_step "9" "Deploying Application to Kubernetes"
cd "$REPO_ROOT/4-kubernetes_manifest"

echo -e "${YELLOW}📋 Deploying application manifest...${NC}"
kubectl apply -f deployment.yml

echo -e "${YELLOW}📋 Installing ALB Controller...${NC}"
chmod +x scripts/1-alb-controller-install-k8s.sh
./scripts/1-alb-controller-install-k8s.sh

echo -e "${YELLOW}📋 Waiting for ALB Controller to be ready...${NC}"
kubectl wait --for=condition=available --timeout=300s deployment/alb-controller -n azure-alb-system

echo -e "${YELLOW}📋 Creating Gateway API resources...${NC}"
chmod +x scripts/2-gateway-api-resources.sh
./scripts/2-gateway-api-resources.sh

echo -e "${YELLOW}📋 Waiting for application to be ready...${NC}"
kubectl wait --for=condition=available --timeout=300s deployment/thomasthornton -n thomasthorntoncloud
echo ""

# Step 7: Get Application URL
print_step "10" "Getting Application URL"
echo -e "${YELLOW}📋 Waiting for gateway to get external IP...${NC}"
sleep 30

GATEWAY_IP=$(kubectl get gateway gateway-01 -n thomasthorntoncloud -o jsonpath='{.status.addresses[0].value}' 2>/dev/null || echo "")

if [ -n "$GATEWAY_IP" ]; then
    echo -e "${GREEN}🎉 Deployment Successful!${NC}"
    echo -e "${GREEN}🌐 Application URL: http://$GATEWAY_IP${NC}"
    echo ""
    echo -e "${BLUE}📋 Testing application...${NC}"
    if curl -s -f "http://$GATEWAY_IP" > /dev/null; then
        echo -e "${GREEN}✅ Application is responding correctly!${NC}"
    else
        echo -e "${YELLOW}⚠️  Application may still be starting up. Please wait a few minutes and try: http://$GATEWAY_IP${NC}"
    fi
else
    echo -e "${YELLOW}⚠️  Gateway IP not yet available. Check status with:${NC}"
    echo "kubectl get gateway gateway-01 -n thomasthorntoncloud"
fi

echo ""
echo -e "${GREEN}🎉 DevOps The Hard Way - Azure deployment completed!${NC}"
echo -e "${BLUE}📋 Next steps:${NC}"
echo "1. Visit your application at the URL above"
echo "2. Monitor resources: kubectl get pods -A"
echo "3. Check logs: kubectl logs -n thomasthorntoncloud deployment/thomasthornton"
echo "4. Clean up when done: ./scripts/cleanup-all.sh"
