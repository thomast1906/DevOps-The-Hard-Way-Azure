#!/bin/sh

# Configuration
AZURE_AD_GROUP_NAME="devopsthehardway-aks-group"

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

echo "Retrieving current user Object ID..."
CURRENT_USER_OBJECTID=$(az ad signed-in-user show --query id -o tsv) || handle_error "Failed to retrieve current user Object ID"

# Check if Azure AD Group exists
echo "Checking if Azure AD Group $AZURE_AD_GROUP_NAME exists..."
GROUP_EXISTS=$(az ad group list --filter "displayName eq '$AZURE_AD_GROUP_NAME'" --query "[].displayName" -o tsv)

if [ "$GROUP_EXISTS" = "$AZURE_AD_GROUP_NAME" ]; then
  echo "Azure AD group $AZURE_AD_GROUP_NAME already exists."
else
  # Create Azure AD Group with description
  echo "Creating Azure AD group $AZURE_AD_GROUP_NAME..."
  az ad group create \
    --display-name $AZURE_AD_GROUP_NAME \
    --mail-nickname $AZURE_AD_GROUP_NAME \
    --description "Administrators for AKS clusters with full kubectl access" || handle_error "Failed to create Azure AD group"
fi

# Check if Current User is already a member of the Azure AD Group
echo "Checking if current user is a member of $AZURE_AD_GROUP_NAME..."
USER_IN_GROUP=$(az ad group member check --group $AZURE_AD_GROUP_NAME --member-id $CURRENT_USER_OBJECTID --query value -o tsv)

if [ "$USER_IN_GROUP" = "true" ]; then
  echo "Current user is already a member of the Azure AD group $AZURE_AD_GROUP_NAME."
else
  # Add Current az login user to Azure AD Group
  echo "Adding current user to Azure AD group $AZURE_AD_GROUP_NAME..."
  az ad group member add --group $AZURE_AD_GROUP_NAME --member-id $CURRENT_USER_OBJECTID || handle_error "Failed to add current user to Azure AD group"
fi

echo "Retrieving Azure AD Group ID..."
AZURE_GROUP_ID=$(az ad group show --group $AZURE_AD_GROUP_NAME --query id -o tsv) || handle_error "Failed to retrieve Azure AD Group ID"

echo "✅ Setup complete!"
echo "==========================================================================="
echo "  AZURE AD GROUP ID: $AZURE_GROUP_ID"
echo "  You'll need this ID for AKS Terraform configurations"
echo "==========================================================================="