#!/bin/bash

RESOURCE_GROUP="devopsthehardway-rg"
AKS_NAME="devopsthehardwayaks"
helm_resource_namespace="azure-alb-system"
VNET_NAME="devopsthehardway-vnet"
ALB_SUBNET_NAME="appgw"
ALB_CONTROLLER_VERSION="1.9.16"

# Create namespace (idempotent)
kubectl create namespace $helm_resource_namespace --dry-run=client -o yaml | kubectl apply -f -

ALB_CLIENT_ID=$(az identity show -g $RESOURCE_GROUP -n azure-alb-identity --query clientId -o tsv)

# Install or upgrade the ALB controller
if helm status alb-controller -n $helm_resource_namespace &>/dev/null; then
  helm upgrade alb-controller oci://mcr.microsoft.com/application-lb/charts/alb-controller \
    --namespace $helm_resource_namespace \
    --version $ALB_CONTROLLER_VERSION \
    --set albController.namespace=$helm_resource_namespace \
    --set albController.podIdentity.clientID=$ALB_CLIENT_ID
else
  helm install alb-controller oci://mcr.microsoft.com/application-lb/charts/alb-controller \
    --namespace $helm_resource_namespace \
    --version $ALB_CONTROLLER_VERSION \
    --set albController.namespace=$helm_resource_namespace \
    --set albController.podIdentity.clientID=$ALB_CLIENT_ID
fi
