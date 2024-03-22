#!/bin/bash

RESOURCE_GROUP="devopsthehardway-rg"
AKS_NAME="devopsthehardwayaks"
helm_resource_namespace="alb"

# create namespace
kubectl create namespace $helm_resource_namespace

# az aks get-credentials --resource-group $RESOURCE_GROUP --name $AKS_NAME
helm install alb-controller oci://mcr.microsoft.com/application-lb/charts/alb-controller \
     --namespace $helm_resource_namespace \
     --version 1.0.0 \
     --set albController.namespace=$helm_resource_namespace \
     --set albController.podIdentity.clientID=$(az identity show -g $RESOURCE_GROUP -n azure-alb-identity --query clientId -o tsv)