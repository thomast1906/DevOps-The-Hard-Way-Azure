#!/bin/bash

RESOURCE_GROUP="devopsthehardway-rg"
AKS_NAME="devopsthehardwayaks"
helm_resource_namespace="azure-alb-system"
VNET_NAME="devopsthehardway-vnet"
ALB_SUBNET_NAME="appgw"

#create namespace
# kubectl create namespace $helm_resource_namespace

# # az aks get-credentials --resource-group $RESOURCE_GROUP --name $AKS_NAME
# helm install alb-controller oci://mcr.microsoft.com/application-lb/charts/alb-controller \
#      --namespace $helm_resource_namespace \
#      --version 1.0.0 \
#      --set albController.namespace=$helm_resource_namespace \
#      --set albController.podIdentity.clientID=$(az identity show -g $RESOURCE_GROUP -n azure-alb-identity --query clientId -o tsv)


ALB_SUBNET_ID=$(az network vnet subnet show --name $ALB_SUBNET_NAME --resource-group $RESOURCE_GROUP --vnet-name $VNET_NAME --query '[id]' --output tsv)

# Creates the namespace for alb-controller
kubectl apply -f - <<EOF
apiVersion: v1
kind: Namespace
metadata:
  name: alb-test-infra
EOF

kubectl apply -f - <<EOF
apiVersion: alb.networking.azure.io/v1
kind: ApplicationLoadBalancer
metadata:
  name: alb-test
  namespace: alb-test-infra
spec:
  associations:
  - $ALB_SUBNET_ID
EOF