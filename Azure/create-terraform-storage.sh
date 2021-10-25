#!/bin/sh

RESOURCE_GROUP_NAME="rg-devops-hard"
STORAGE_ACCOUNT_NAME="sadevopshard88392"
LOCATION = "eastus"

# Create Resource Group
az group create -l $LOCATION -n $RESOURCE_GROUP_NAME

# Create Storage Account
az storage account create -n $STORAGE_ACCOUNT_NAME -g $RESOURCE_GROUP_NAME -l $LOCATION --sku Standard_LRS

# Create Storage Account blob
az storage container create  --name tfstate --account-name $STORAGE_ACCOUNT_NAME