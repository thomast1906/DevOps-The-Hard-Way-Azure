# Create An AKS Cluster and IAM Roles

Before proceeding, ensure that the values in the terraform.tfvars file are accurate for your environment. You may need to customize these values to match your specific configuration.

In this lab you will create:
- The AKS cluster
- The appropriate IAM roles for AKS

## Create the AKS Terraform Configuration

1. You can find the Terraform configuration for AKS [here](https://github.com/thomast1906/DevOps-The-Hard-Way-Azure/tree/main/Terraform-AZURE-Services-Creation/AKS). The Terraform configuration files are used to create an AKS cluster and IAM Role/Policy for AKS. 

The Terraform `aks.tf` will:
- Use the `azurerm_kubernetes_cluster` Terraform resource to AKS Cluster 
- Use the `azurerm_role_assignment` Terraform resource to create the two neccessary role assignments 
- Use the `uksouth` region, but feel free to change that if you'd like

The Terraform `managed_identity.tf` will:
- Use the `azurerm_user_assigned_identity` Terraform resource to create a user assigned identity as part of the Azure Application Gateway for Containers setup
- Use the `azurerm_federated_identity_credential` Terraform resource to create a federated identity credential as part of the Azure Application Gateway for Containers setup

The Terraform `rbac.tf` will:
- Use the `azurerm_role_assignment` Terraform resource to create the necessary role assignments for the AKS cluster
- Use the `azurerm_role_definition` Terraform resource to create the necessary role definitions for the AKS cluster

2. In line 8 of `terraform.tfvars` replace the actual Azure AD Group ID you noted down [earlier](https://github.com/thomast1906/DevOps-The-Hard-Way-Azure/blob/main/Azure/2-Create-Azure-AD-Group-AKS-Admins.md)

3. Create the bucket by running the following:
- `terraform init` - To initialize the working directory and pull down the provider
- `terraform plan` - To go through a "check" and confirm the configurations are valid
- `terraform apply` - To create the resource
