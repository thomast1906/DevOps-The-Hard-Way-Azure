# Configure Storage Account for Terraform State File

## 🎯 Purpose
In this lab, you'll create a secure location to store the remote Terraform State file. This is crucial for maintaining consistency and collaboration in your infrastructure-as-code projects.

## 🛠️ Create Blob Storage for Terraform State File

### Prerequisites
- [ ] Azure CLI installed and configured (`az login` executed)
- [ ] Contributor permissions on your Azure subscription
- [ ] Basic understanding of Azure Storage concepts

### Steps

1. **Customise Variables**
   - Open the [create-terraform-storage.sh](https://github.com/thomast1906/DevOps-The-Hard-Way-Azure/blob/main/1-Azure/scripts/create-terraform-storage.sh) script.
   - Locate the following lines:
   
     ```bash
      RESOURCE_GROUP_NAME="devopshardway-rg"
      STORAGE_ACCOUNT_NAME="devopshardwaysa"
     ```

   - Replace the placeholders with your desired names.

2. **Run the Script**

   - Run the following command in your terminal:

     ```bash
     ./scripts/1-create-terraform-storage.sh
     ```

3. **What's Happening Behind the Scenes?**
   The script performs these actions:
   - [ ] Creates an Azure Resource Group with appropriate tags
   - [ ] Sets up an Azure Storage Account with enhanced security settings:
     - Encryption enabled for blob storage
     - TLS 1.2 enforced
     - Public access to blobs disabled
   - [ ] Establishes an Azure Blob storage container
   - [ ] Outputs configuration for your Terraform backend

## 🔍 Verification
To ensure everything was set up correctly:

1. Log into the [Azure Portal](https://portal.azure.com).
2. Navigate to your newly created Resource Group.
3. Verify the presence of the Storage Account.
4. Within the Storage Account, check for the Blob container.
5. It should look similar to this:

![](images/storage-account.png)

## 🧠 Knowledge Check
After running the script, try to answer these questions:
1. Why is it important to use remote state storage for Terraform?
2. What are the benefits of using Azure Blob Storage for this purpose?
3. How would you access this state file in your Terraform configurations?

## 💡 Pro Tip
Consider implementing these additional security measures for production environments:
1. Enable soft delete and versioning for your blob storage to protect against accidental deletion
2. Set up a resource lock to prevent accidental deletion of the storage account
3. Use Managed Identities instead of storage account keys for authentication
4. Configure network rules to restrict access to specific networks
5. Set up Azure Key Vault to store sensitive backend configuration

Example of adding a resource lock:
```bash
az lock create --name LockTerraformStorage --lock-type CanNotDelete \
  --resource-group devopshardway-rg \
  --resource-name devopshardwaysa \
  --resource-type Microsoft.Storage/storageAccounts
```