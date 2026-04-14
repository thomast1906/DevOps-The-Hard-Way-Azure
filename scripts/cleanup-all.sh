#!/bin/bash

# DevOps The Hard Way - Azure - Cleanup Script
# This script deletes the resource groups which removes all resources

set -e  # Exit on any error

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
# Must match 1-Azure/scripts/1-create-terraform-storage.sh naming
TERRAFORM_RG="${TF_RG:-devopshardway-rg}"

echo -e "${RED}🗑️  DevOps The Hard Way - Azure - CLEANUP${NC}"
echo -e "${RED}⚠️  WARNING: This will DELETE ALL resources by removing resource groups!${NC}"
echo -e "${YELLOW}Project: ${PROJECT_NAME}${NC}"
echo -e "${YELLOW}Resource Groups to Delete:${NC}"
echo -e "${YELLOW}  • ${RESOURCE_GROUP}${NC}"
echo -e "${YELLOW}  • ${PROJECT_NAME}-node-rg${NC}"
echo -e "${YELLOW}  • ${TERRAFORM_RG} (optional)${NC}"
echo ""

# Confirmation prompt
read -p "Are you sure you want to delete all resource groups? Type 'DELETE' to confirm: " confirmation
if [ "$confirmation" != "DELETE" ]; then
    echo -e "${GREEN}✅ Cleanup cancelled${NC}"
    exit 0
fi

echo ""
echo -e "${RED}🗑️  Starting resource group deletion...${NC}"

# Check if logged into Azure
if ! az account show &> /dev/null; then
    echo -e "${RED}❌ Not logged into Azure. Please login first.${NC}"
    az login
fi

echo -e "${YELLOW}📋 Deleting main resource group: ${RESOURCE_GROUP}${NC}"
az group delete --name "$RESOURCE_GROUP" --yes --no-wait 2>/dev/null || echo -e "${YELLOW}⚠️  Resource group may not exist${NC}"

echo -e "${YELLOW}📋 Deleting AKS node resource group: ${PROJECT_NAME}-node-rg${NC}"
az group delete --name "${PROJECT_NAME}-node-rg" --yes --no-wait 2>/dev/null || echo -e "${YELLOW}⚠️  Node resource group may not exist${NC}"

# Optional: Delete Terraform state storage
echo ""
echo -e "${YELLOW}⚠️  Do you want to delete the Terraform state storage as well?${NC}"
echo -e "${YELLOW}This will remove: ${TERRAFORM_RG}${NC}"
read -p "Delete Terraform state storage? (y/N): " delete_state

if [[ "$delete_state" =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}📋 Deleting Terraform state resource group: ${TERRAFORM_RG}${NC}"
    az group delete --name "$TERRAFORM_RG" --yes --no-wait 2>/dev/null || echo -e "${YELLOW}⚠️  Terraform state resource group may not exist${NC}"
    echo -e "${GREEN}✅ Terraform state storage cleanup initiated${NC}"
else
    echo -e "${BLUE}ℹ️  Terraform state storage preserved${NC}"
fi

echo ""
echo -e "${GREEN}✅ Resource group deletion initiated!${NC}"
echo ""
echo -e "${BLUE}📋 What's being deleted:${NC}"
echo "• Main resource group: $RESOURCE_GROUP"
echo "  - AKS cluster and all nodes"
echo "  - Virtual Network and subnets"
echo "  - Log Analytics workspace"
echo "  - Azure Container Registry"
echo "  - Load balancers and public IPs"
echo "  - All networking components"
echo "• AKS node resource group: ${PROJECT_NAME}-node-rg"
echo "  - AKS node VMs and disks"
echo "  - Load balancers and networking"
if [[ "$delete_state" =~ ^[Yy]$ ]]; then
    echo "• Terraform state storage: $TERRAFORM_RG"
fi

echo ""
echo -e "${BLUE}📋 Notes:${NC}"
echo "• Resource group deletions are running in the background"
echo "• It may take 10-15 minutes for all resources to be fully removed"
echo "• Check deletion progress: az group list --query \"[?contains(name,'$PROJECT_NAME')]\""
echo "• Check Azure Portal to confirm all resources are deleted"

echo ""
echo -e "${GREEN}🎉 DevOps The Hard Way - Azure cleanup completed!${NC}"
