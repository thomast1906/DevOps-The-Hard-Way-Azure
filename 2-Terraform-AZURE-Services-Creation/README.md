# Terraform Azure Services Creation for DevOps The Hard Way

## Overview
This directory contains the Terraform configurations needed to create the core Azure infrastructure components for the DevOps The Hard Way - Azure project. Each step builds upon the previous, creating a complete infrastructure for hosting containerised applications in Azure Kubernetes Service (AKS).

## Labs in this Section

### [1. Create Azure Container Registry (ACR)](./1-Create-ACR.md)
Set up an Azure Container Registry to store Docker images used by your application.

### [2. Create Virtual Network](./2-Create-VNET.md)
Create a Virtual Network with the necessary subnets for AKS and Application Gateway.

### [3. Create Log Analytics Workspace](./3-Create-Log-Analytics.md)
Establish a Log Analytics workspace to monitor your AKS cluster and applications.

### [4. Create AKS Cluster and IAM Roles](./4-Create-AKS-Cluster-IAM-Roles.md)
Deploy an Azure Kubernetes Service cluster with proper Azure AD integration and RBAC.

### [5. Set Up CI/CD for AKS Cluster](./5-Run-CICD-For-AKS-Cluster.md)
Configure GitHub Actions for continuous integration and deployment to your AKS cluster.

## Terraform Structure

Each component is organised in its own directory with a consistent structure:
- `providers.tf`: Defines Azure provider configuration
- `variables.tf`: Declares input variables
- `terraform.tfvars`: Sets default values for variables
- Resource-specific `.tf` files: Contain the actual resource definitions
- `data.tf`: Contains data sources used by the configurations

## Pre-requisites

Before starting these labs, ensure you have:

1. Completed the steps in the [1-Azure](../1-Azure) section
2. Terraform installed (version 1.9.6 or higher)
3. Azure CLI installed and configured (`az login` executed)
4. Basic familiarity with Terraform and Azure infrastructure concepts

## Best Practices Applied

- Resource naming conventions following Azure recommendations
- Consistent tagging across all resources for better governance
- Secure network design with proper subnet segregation
- RBAC-based access control
- Infrastructure as Code for reproducibility and consistency
- Remote state management using Azure Storage
