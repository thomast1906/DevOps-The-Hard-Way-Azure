# Create AKS Cluster With CI/CD

## 🎯 Purpose
In this lab, you'll learn how to create an Azure Kubernetes Service (AKS) cluster using GitHub Actions for continuous integration and continuous deployment (CI/CD).

## 🛠️ Setup and Configuration

### Prerequisites
- [ ] Basic understanding of Terraform and GitHub Actions


### Steps

1. **Review and Customise Variables**
   - Open the `terraform.tfvars` file in the [AKS Terraform configuration](https://github.com/thomast1906/DevOps-The-Hard-Way-Azure/tree/updates-sept-2024/2-Terraform-AZURE-Services-Creation/4-aks).
   - Ensure all values are accurate for your environment.

2. **Set Up Azure Service Principal**
   Create an Azure Service Principal using one of these methods:
   - Azure CLI:
     ```bash
     az ad sp create-for-rbac --name devopsthehardway
     ```
   - [Azure Portal](https://docs.microsoft.com/en-us/azure/active-directory/develop/howto-create-service-principal-portal)

   **Note**: Assign appropriate IAM permissions (e.g., Contributor access to the subscription) to the Service Principal.

3. **Configure GitHub Secrets**
   Add the following secrets to your GitHub repository (Settings > Secrets):
   - `AZURE_AD_CLIENT_ID`: Service principal ID
   - `AZURE_AD_CLIENT_SECRET`: Service principal secret
   - `AZURE_AD_TENANT_ID`: Azure AD tenant ID
   - `AZURE_SUBSCRIPTION_ID`: Target Azure subscription ID

4. **Set Up GitHub Actions Workflow**
   - Navigate to the Actions tab in your GitHub repository.
   - Select the existing `CI` workflow.
   - Choose to run the workflow from the main branch.

## 🔍 Verification
After running the workflow:
1. Check the GitHub Actions logs for successful completion.
2. Log into the [Azure Portal](https://portal.azure.com)
3. Navigate to Kubernetes services
4. Verify that your new AKS cluster has been updated or created.

### 🧠 Knowledge Check
The GitHub Actions workflow:
- [ ] Triggers manually (`workflow_dispatch`) or on pull requests/pushes to main
- [ ] Checks out the code
- [ ] Authenticates with Azure
- [ ] Sets up Terraform
- [ ] Formats and validates Terraform code
- [ ] Initialises Terraform
- [ ] Plans the Terraform changes
- [ ] Applies the Terraform configuration to create the AKS cluster

## 💡 Pro Tip
Consider using separate state files for different environments (dev, staging, production) to manage multiple AKS clusters and environments efficiently
