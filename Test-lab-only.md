# Test Lab Only — End-to-End Deployment Guide

> ⚠️ This file is for **local/lab testing only**. It is not part of the main tutorial content.

## Prerequisites

Ensure the following tools are installed and up to date:

| Tool | Minimum Version |
|------|----------------|
| Azure CLI | Latest |
| Terraform | 1.14.8 |
| Docker | Latest |
| kubectl | Latest |
| Helm | Latest |

Log in to Azure before running any scripts:

```bash
az login
az account set --subscription "<your-subscription-id>"
```

## Configuration

The deploy script uses these environment variables (with defaults shown):

```bash
export PROJECT_NAME="devopsthehardway"   # Prefix for all Azure resources
export LOCATION="uksouth"                # Azure region
```

> **AKS version note:** The deployment targets Kubernetes `1.35`. Verify it is available in your chosen region before deploying:
> ```bash
> az aks get-versions --location uksouth --query "values[].version" -o table
> ```

## Automated Deployment

Run from the **repository root**:

```bash
# Clone the repository
git clone https://github.com/thomast1906/DevOps-The-Hard-Way-Azure.git
cd DevOps-The-Hard-Way-Azure

# Deploy everything (infrastructure + app)
./scripts/deploy-all.sh

# Clean up all resources when done
./scripts/cleanup-all.sh
```

The deploy script will:
1. Verify Azure authentication and prerequisites
2. Create Terraform remote state storage (`${PROJECT_NAME}-terraform-rg`)
3. Create an Azure AD group for AKS admins
4. Deploy ACR, VNet, Log Analytics, and AKS via Terraform (each with its own remote state key)
5. Build and push the Docker image to ACR
6. Deploy the application to Kubernetes
7. Install the ALB Controller and configure Gateway API resources
8. Print the application URL when ready

## GitHub Actions Deployment

The repository includes a full GitHub Actions workflow (`deploy-full.yml`) for automated deployment:

1. **Fork this repository**
2. **Set up Azure OIDC secrets** in your repository settings:
   - `AZURE_AD_CLIENT_ID`
   - `AZURE_AD_TENANT_ID`
   - `AZURE_SUBSCRIPTION_ID`
3. **Trigger the workflow** via the **Actions** tab → `Deploy DevOps The Hard Way - Azure` → `Run workflow`

Choose an environment (`dev` / `staging` / `prod`) and optionally enable **Destroy after deploy** for ephemeral test runs.

## Versions in Use

| Component | Version |
|-----------|---------|
| Terraform | 1.14.8 |
| Azure Provider (azurerm) | ~> 4.68 |
| AKS Kubernetes | 1.35 |
| Python base image | 3.13-slim |
| Flask | 3.1.3 |
| Werkzeug | 3.1.8 |
