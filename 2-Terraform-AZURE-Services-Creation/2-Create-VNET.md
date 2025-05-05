# Create an Azure VNET

## 🎯 Purpose
In this lab, you'll set up the networking infrastructure for your AKS deployment, including a Virtual Network (VNET), Network Security Group (NSG), and Azure Application Gateway for Containers.

## 🛠️ Create the Azure VNET Terraform Configuration

### Prerequisites
- [ ] Basic understanding of Azure networking concepts

### Steps

1. **Review and Change Terraform .tfvars**
   - Open the [terraform.tfvars](https://github.com/thomast1906/DevOps-The-Hard-Way-Azure/tree/main/2-Terraform-AZURE-Services-Creation/2-vnet/terraform.tfvars) file.
   - Ensure all values are accurate for your environment.

2. **Understand the Terraform Configuration**
   Review the [VNET Terraform configuration](https://github.com/thomast1906/DevOps-The-Hard-Way-Azure/tree/main/2-Terraform-AZURE-Services-Creation/2-vnet). The configuration includes:

   **vnet.tf:**
   - [ ] Uses a Terraform backend to store the `.tfstate` in Azure Storage
   - [ ] Creates a VNET using `azurerm_virtual_network`
   - [ ] Creates subnets using `azurerm_subnet`
   - [ ] Uses the `uksouth` region (can change if desired)

   **nsg.tf:**
   - [ ] Creates a NSG using `azurerm_network_security_group`
   - [ ] Associates NSG to subnets using `azurerm_subnet_network_security_group_association`

   **alb.tf:**
   - [ ] Creates an Azure Application Gateway for Containers using `azurerm_application_load_balancer`
   - [ ] Associates the Gateway with VNET using `azurerm_application_load_balancer_subnet_association`
   - [ ] Creates a frontend for the Gateway using `azurerm_application_load_balancer_frontend`

3. **Create the Resources**
   Run the following commands in your terminal:
   ```bash
   terraform init
   terraform plan
   terraform apply

## 🔍 Verification

To ensure the resources were created successfully:
1. Log into the [Azure Portal](https://portal.azure.com)
2. Navigate to the Resource Group
3. Verify the presence of the VNET, NSG, and Application Gateway for Containers:

Example screenshot of created resources:

![](images/2-vnet.png)


## 🧠 Knowledge Check

After creating the resources, consider these questions:
1. Why is it important to plan your VNET and subnet structure before deployment?
2. How does the NSG enhance the security of your AKS deployment?
3. What benefits does the Azure Application Gateway for Containers provide?

## 💡 Pro Tip

Consider using [Azure Network Watcher](https://learn.microsoft.com/en-us/azure/network-watcher/network-watcher-overview) to visualise and diagnose your network topology and connectivity issues.
