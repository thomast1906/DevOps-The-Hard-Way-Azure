#!/bin/sh

RESOURCE_GROUP_NAME="devopshardway-rg"
STORAGE_ACCOUNT_NAME="devopshardwaysa"

# Check if Resource Group exists
RESOURCE_GROUP_EXISTS=$(az group exists --name $RESOURCE_GROUP_NAME)

if [ "$RESOURCE_GROUP_EXISTS" = "true" ]; then
  echo "Resource group $RESOURCE_GROUP_NAME already exists."
else
  # Create Resource Group
  az group create -l uksouth -n $RESOURCE_GROUP_NAME
fi

# Check if Storage Account exists
STORAGE_ACCOUNT_EXISTS=$(az storage account check-name --name $STORAGE_ACCOUNT_NAME --query 'nameAvailable' --output tsv)

if [ "$STORAGE_ACCOUNT_EXISTS" = "false" ]; then
  echo "Storage account $STORAGE_ACCOUNT_NAME is already created in resource group $RESOURCE_GROUP_NAME."
else
  # Create Storage Account
  az storage account create -n $STORAGE_ACCOUNT_NAME -g $RESOURCE_GROUP_NAME -l uksouth --sku Standard_LRS

  # Create Storage Account blob
  az storage container create --name tfstate --account-name $STORAGE_ACCOUNT_NAME
fi