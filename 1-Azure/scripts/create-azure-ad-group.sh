#!/bin/sh

AZURE_AD_GROUP_NAME="devopsthehardway-aks-group"
CURRENT_USER_OBJECTID=$(az ad signed-in-user show --query id -o tsv)

# Check if Azure AD Group exists
GROUP_EXISTS=$(az ad group list --filter "displayName eq '$AZURE_AD_GROUP_NAME'" --query "[].displayName" -o tsv)

if [ "$GROUP_EXISTS" = "$AZURE_AD_GROUP_NAME" ]; then
  echo "Azure AD group $AZURE_AD_GROUP_NAME already exists."
else
  # Create Azure AD Group
  az ad group create --display-name $AZURE_AD_GROUP_NAME --mail-nickname $AZURE_AD_GROUP_NAME
fi

# Check if Current User is already a member of the Azure AD Group
USER_IN_GROUP=$(az ad group member check --group $AZURE_AD_GROUP_NAME --member-id $CURRENT_USER_OBJECTID --query value -o tsv)

if [ "$USER_IN_GROUP" = "true" ]; then
  echo "Current user is already a member of the Azure AD group $AZURE_AD_GROUP_NAME."
else
  # Add Current az login user to Azure AD Group
  az ad group member add --group $AZURE_AD_GROUP_NAME --member-id $CURRENT_USER_OBJECTID
fi

AZURE_GROUP_ID=$(az ad group show --group $AZURE_AD_GROUP_NAME --query id -o tsv)

echo "AZURE AD GROUP ID IS: $AZURE_GROUP_ID"