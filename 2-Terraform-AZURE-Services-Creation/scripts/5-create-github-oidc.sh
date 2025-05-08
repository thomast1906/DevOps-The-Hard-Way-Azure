#!/bin/sh

# Configuration
APP_DISPLAY_NAME="DevOps-The-Hardway-Azure-GitHub-OIDC"
GITHUB_REPO="thomast1906/DevOps-The-Hard-Way-Azure"

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

# Check if Azure AD App already exists
echo "Checking if Azure AD application $APP_DISPLAY_NAME already exists..."
APP_EXISTS=$(az ad app list --display-name "$APP_DISPLAY_NAME" --query "[].displayName" -o tsv)

if [ "$APP_EXISTS" = "$APP_DISPLAY_NAME" ]; then
    echo "Azure AD application $APP_DISPLAY_NAME already exists."
    APP_ID=$(az ad app list --display-name "$APP_DISPLAY_NAME" --query "[0].appId" -o tsv)
else
    # Create Azure AD application registration
    echo "Creating Azure AD application $APP_DISPLAY_NAME..."
    APP_ID=$(az ad app create --display-name "$APP_DISPLAY_NAME" --query appId -o tsv) || handle_error "Failed to create Azure AD application"
fi

# Check if service principal exists
echo "Checking if service principal for $APP_DISPLAY_NAME already exists..."
SP_EXISTS=$(az ad sp list --filter "appId eq '$APP_ID'" --query "[].id" -o tsv)

if [ -n "$SP_EXISTS" ]; then
    echo "Service principal for $APP_DISPLAY_NAME already exists."
    SP_ID=$SP_EXISTS
else
    # Create service principal
    echo "Creating service principal for $APP_DISPLAY_NAME..."
    SP_ID=$(az ad sp create --id "$APP_ID" --query id -o tsv) || handle_error "Failed to create service principal"
fi

# Function to create or update federated credential
create_federated_credential() {
    local name=$1
    local subject=$2
    local description=$3
    
    echo "Checking if federated credential $name already exists..."
    CRED_EXISTS=$(az ad app federated-credential list --id "$APP_ID" --query "[?name=='$name'].name" -o tsv)
    
    if [ "$CRED_EXISTS" = "$name" ]; then
        echo "Federated credential $name already exists."
    else
        echo "Creating federated credential $name..."
        az ad app federated-credential create \
          --id "$APP_ID" \
          --parameters "{
            \"name\": \"$name\",
            \"issuer\": \"https://token.actions.githubusercontent.com\",
            \"subject\": \"$subject\",
            \"description\": \"$description\",
            \"audiences\": [\"api://AzureADTokenExchange\"]
          }" || handle_error "Failed to create federated credential $name"
    fi
}

# Create federated credentials for different GitHub workflows
create_federated_credential "github-oidc-branch" "repo:$GITHUB_REPO:ref:refs/heads/main" "GitHub Actions OIDC - Branch Workflows (main)"
create_federated_credential "github-oidc-branch-renovate" "repo:$GITHUB_REPO:ref:refs/heads/renovate/configure" "GitHub Actions OIDC - Branch Renovate Workflows (renovate)"
create_federated_credential "github-oidc-pull-request" "repo:$GITHUB_REPO:pull_request" "GitHub Actions OIDC - Pull Request Workflows"

# Get subscription ID
SUBSCRIPTION_ID=$(az account show --query id -o tsv)

echo "✅ Setup complete!"
echo "==========================================================================="
echo "  APPLICATION (CLIENT) ID: $APP_ID"
echo "  SERVICE PRINCIPAL ID:    $SP_ID"
echo "  TENANT ID:               $(az account show --query tenantId -o tsv)"
echo "  SUBSCRIPTION ID:         $SUBSCRIPTION_ID"
echo "==========================================================================="
echo "Next step: Assign appropriate roles to the service principal:"
echo "  az role assignment create --assignee $SP_ID --role \"Contributor\" \\"
echo "    --scope \"/subscriptions/$SUBSCRIPTION_ID\""
echo "==========================================================================="
echo "For GitHub Actions, add these secrets to your repository:"
echo "  AZURE_CLIENT_ID:         $APP_ID"
echo "  AZURE_TENANT_ID:         $(az account show --query tenantId -o tsv)"
echo "  AZURE_SUBSCRIPTION_ID:   $SUBSCRIPTION_ID"
echo "==========================================================================="