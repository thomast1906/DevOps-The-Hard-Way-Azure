#!/bin/sh

AZURE_AD_GROUP_NAME="christopher-aks-group"
CURRENT_USER_OBJECTID=$(az ad signed-in-user show --query id -o tsv)

# Create Azure AD Group
az ad group create --display-name $AZURE_AD_GROUP_NAME --mail-nickname $AZURE_AD_GROUP_NAME

# Add Current az login user to Azure AD Group
az ad group member add --group $AZURE_AD_GROUP_NAME --member-id $CURRENT_USER_OBJECTID

AZURE_GROUP_ID=$(az ad group show --group "christopher-aks-group" --query id -o tsv)

echo "Current user is: $CURRENT_USER_OBJECTID"
echo "AZURE AD GROUP ID IS: $AZURE_GROUP_ID"