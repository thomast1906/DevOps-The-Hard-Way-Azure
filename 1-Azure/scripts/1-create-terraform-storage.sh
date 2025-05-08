#!/bin/sh

# Configuration
RESOURCE_GROUP_NAME="devopshardway-rg"
STORAGE_ACCOUNT_NAME="devopshardwaysa"
LOCATION="uksouth"
CONTAINER_NAME="tfstate"

# Error handling function
handle_error() {
    echo "ERROR: $1"
    exit 1
}

# Verify Azure CLI is installed and user is logged in
if ! command -v az &> /dev/null; then
    handle_error "Azure CLI is not installed. Please install it first: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli"
fi

# Check if user is logged in
echo "Verifying Azure CLI login status..."
az account show &> /dev/null || handle_error "You are not logged in to Azure CLI. Please run 'az login' first."

# Check if Resource Group exists
echo "Checking if resource group $RESOURCE_GROUP_NAME exists..."
RESOURCE_GROUP_EXISTS=$(az group exists --name $RESOURCE_GROUP_NAME)

if [ "$RESOURCE_GROUP_EXISTS" = "true" ]; then
  echo "Resource group $RESOURCE_GROUP_NAME already exists."
else
  # Create Resource Group
  echo "Creating resource group $RESOURCE_GROUP_NAME in $LOCATION..."
  az group create -l $LOCATION -n $RESOURCE_GROUP_NAME --tags "Purpose=azure-devops-hardway" || handle_error "Failed to create resource group"
fi

# Check if Storage Account exists
echo "Checking if storage account $STORAGE_ACCOUNT_NAME exists..."
STORAGE_ACCOUNT_EXISTS=$(az storage account check-name --name $STORAGE_ACCOUNT_NAME --query 'nameAvailable' --output tsv)

if [ "$STORAGE_ACCOUNT_EXISTS" = "false" ]; then
  echo "Storage account $STORAGE_ACCOUNT_NAME is already created in resource group $RESOURCE_GROUP_NAME."
else
  # Create Storage Account with improved security settings
  echo "Creating storage account $STORAGE_ACCOUNT_NAME..."
  az storage account create \
    -n $STORAGE_ACCOUNT_NAME \
    -g $RESOURCE_GROUP_NAME \
    -l $LOCATION \
    --sku Standard_LRS \
    --encryption-services blob \
    --min-tls-version TLS1_2 \
    --allow-blob-public-access false \
    --tags "Purpose=azure-devops-hardway" || handle_error "Failed to create storage account"

  # Create Storage Account blob container
  echo "Creating blob container $CONTAINER_NAME..."
  az storage container create \
    --name $CONTAINER_NAME \
    --account-name $STORAGE_ACCOUNT_NAME \
    --auth-mode login || handle_error "Failed to create blob container"

  # Output the access key (in a real environment, consider using managed identities instead)
  echo "Retrieving storage account key..."
  ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)
  
  echo "Configuration for terraform backend:"
  echo "terraform {"
  echo "  backend \"azurerm\" {"
  echo "    resource_group_name  = \"$RESOURCE_GROUP_NAME\""
  echo "    storage_account_name = \"$STORAGE_ACCOUNT_NAME\""
  echo "    container_name       = \"$CONTAINER_NAME\""
  echo "    key                  = \"terraform.tfstate\""
  echo "  }"
  echo "}"
  
  echo "Setup complete!"
fi