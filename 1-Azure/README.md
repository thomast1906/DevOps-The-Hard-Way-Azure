# Azure Setup for DevOps The Hard Way

## Overview
This directory contains the foundational Azure setup needed for the DevOps The Hard Way - Azure project. These steps establish the core Azure resources that will be used throughout the tutorial.

## Labs in this Section

### [1. Configure Terraform Remote Storage](./1-Configure-Terraform-Remote-Storage.md)
Set up an Azure Storage Account to securely store your Terraform state files, which is essential for team collaboration and state management.

### [2. Create Azure AD Group for AKS Admins](./2-Create-Azure-AD-Group-AKS-Admins.md)
Create an Azure Active Directory group to manage administrative access to your Kubernetes clusters with proper RBAC controls.

## Scripts

The `scripts` directory contains shell scripts that automate the setup process:

- [`create-terraform-storage.sh`](./scripts/create-terraform-storage.sh): Creates a resource group, storage account, and blob container for Terraform state
- [`create-azure-ad-group.sh`](./scripts/create-azure-ad-group.sh): Creates an Azure AD Group for AKS administrators

## Pre-requisites

Before starting these labs, ensure you have:

1. An Azure account with appropriate permissions
2. Azure CLI installed and configured (`az login`)
3. Basic familiarity with Azure services and Terraform concepts

## Best Practices Applied

- Resource naming conventions
- Security-enhanced storage configuration
- RBAC-based access control
- Infrastructure as Code for reproducibility
- Proper error handling in scripts
