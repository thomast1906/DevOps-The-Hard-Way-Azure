# Create an Azure VNET

Before proceeding, ensure that the values in the terraform.tfvars file are accurate for your environment. You may need to customize these values to match your specific configuration.

In this lab you will:
- Create a Virtual Network (VNET) that will be used to deploy your AKS instance into
- Create a Network Security Group (NSG) and assign to the relevant subnets
- Create an Azure Application Gateway for Containers and associate it with the VNET

## Create the Azure VNET Terraform Configuration

1. You can find the Terraform configuration for Azure Virtual Network [here](https://github.com/thomast1906/DevOps-The-Hard-Way-Azure/tree/main/Terraform-AZURE-Services-Creation/VNET). The Terraform configuration files are used to create an Azure Vitual Network. 

The Terraform `vnet.tf` will:
- Use a Terraform backend to store the `.tfstate` in an Azure Storage Account
- Use the `azurerm_virtual_network` Terraform resource to create a VNET. 
- Use the `azurerm_subnet` Terraform resource to create relevant subnets. 
- Use the `uksouth` region, but feel free to change that if you'd like

The Terraform `nsg.tf` will:
- Use the `azurerm_network_security_group` Terraform resource to create a NSG.
- Use the `azurerm_subnet_network_security_group_association` Terraform resource to associate the NSG to the relevant subnets.

The Terraform `alb.tf` will:
- Use the `azurerm_application_load_balancer` Terraform resource to create an Azure Application Gateway for Containers.
- Use the `azurerm_application_load_balancer_subnet_association` Terraform resource to associate the Azure Application Gateway with the VNET.
- Use the `azurerm_application_load_balancer_frontend` Terraform resource to create a frontend for the Azure Application Gateway.


2. Create the VNET, NSG & Azure Application Gateway for Containers by running the following:
- `terraform init` - To initialize the working directory and pull down the provider
- `terraform plan` - To go through a "check" and confirm the configurations are valid
- `terraform apply` - To create the resource