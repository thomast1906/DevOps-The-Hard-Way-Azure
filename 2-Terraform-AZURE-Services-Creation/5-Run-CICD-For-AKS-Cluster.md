# Create AKS Cluster With CI/CD

## 🎯 Purpose
In this lab, you'll learn how to create an Azure Kubernetes Service (AKS) cluster using GitHub Actions for continuous integration and continuous deployment (CI/CD).

## 🛠️ Setup and Configuration

### Prerequisites
- [ ] Basic understanding of Terraform and GitHub Actions


### Steps

1. **Review and Customise Variables**
   - Open the `terraform.tfvars` file in the [AKS Terraform configuration](https://github.com/thomast1906/DevOps-The-Hard-Way-Azure/tree/main/2-Terraform-AZURE-Services-Creation/4-aks).
   - Ensure all values are accurate for your environment.

2. **Set Up GitHub OIDC Authentication with Azure**

   Set up a more secure authentication method using GitHub OIDC (OpenID Connect) with Azure:

   - First, customise the [script](https://github.com/thomast1906/DevOps-The-Hard-Way-Azure/tree/main/2-Terraform-AZURE-Services-Creation/scripts/5-create-github-oidc.sh) variables if needed:
     ```bash     
     # Variables you may want to customise:
     APP_DISPLAY_NAME="DevOps-The-Hardway-Azure-GitHub-OIDC"  # Name of the Azure AD app registration
     GITHUB_REPO="thomast1906/DevOps-The-Hard-Way-Azure"  # Your GitHub repository name
     ```
     Update these variables to match your specific environment if different from the defaults.
   
   - Run the provided script:
     ```bash
     ./scripts/5-create-github-oidc.sh
     ```
   
   The script performs these actions:
   - [ ] Creates an Azure AD application registration named "DevOps-The-Hardway-Azure"
   - [ ] Creates a corresponding service principal 
   - [ ] Sets up federated credentials for:
     - GitHub main branch workflows (`repo:thomast1906/DevOps-The-Hard-Way-Azure:ref:refs/heads/main`)
     - Renovate branch workflows (`repo:thomast1906/DevOps-The-Hard-Way-Azure:ref:refs/heads/renovate/configure`)
     - Pull request workflows (`repo:thomast1906/DevOps-The-Hard-Way-Azure:pull_request`)
   
   If you need to customise the federated credentials for different branches or repositories, edit the `create_federated_credential` function calls in the script.

   **Note**: After running the script, it will output all the necessary information and next steps. You'll need to assign appropriate IAM permissions (e.g., Contributor access to the subscription) to the Service Principal using:
   ```bash
   # Store the app ID in a variable
   APP_ID=$(az ad app list --display-name "DevOps-The-Hardway-Azure-GitHub-OIDC" --query "[].appId" -o tsv)
   
   # Get the service principal ID
   SP_ID=$(az ad sp list --filter "appId eq '$APP_ID'" --query "[].id" -o tsv)

   # Assign Contributor role to the subscription
   az role assignment create --assignee $SP_ID --role "Contributor" --scope "/subscriptions/YOUR_SUBSCRIPTION_ID"
   ```
   
   The script will automatically output the exact commands needed with your specific IDs, so you can simply copy and paste them from the terminal output.

3. **Configure GitHub Repository Settings**
   Configure your GitHub repository to use the OIDC connection:
   
   - Add the following secrets to your GitHub repository (Settings > Secrets > Actions):
     - `AZURE_CLIENT_ID`: The App ID you created
     - `AZURE_TENANT_ID`: Your Azure AD tenant ID
     - `AZURE_SUBSCRIPTION_ID`: Your Azure subscription ID
   
   Note: All three values will be automatically displayed in the output of the `5-create-github-oidc.sh` script, so you can copy them directly from there.

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
- [ ] Authenticates with Azure using OIDC (no secrets stored in GitHub)
- [ ] Sets up Terraform
- [ ] Formats and validates Terraform code
- [ ] Initialises Terraform
- [ ] Plans the Terraform changes
- [ ] Applies the Terraform configuration to create the AKS cluster

## 💡 Pro Tip
Consider implementing these additional best practices:
- Use separate state files for different environments (dev, staging, production) to manage multiple AKS clusters efficiently
- Implement branch protection rules to prevent direct pushes to main
- Set up required reviewers for pull requests to the main branch
- Configure federated credentials with more specific patterns if needed:
  ```bash
  # For specific environments or branches
  "subject": "repo:thomast1906/DevOps-The-Hard-Way-Azure:ref:refs/heads/env-*"
  ```
