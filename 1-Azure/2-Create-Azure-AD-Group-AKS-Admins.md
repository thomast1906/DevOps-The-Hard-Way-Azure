# Create Azure AD Group for AKS Admins

## 🎯 Purpose
In this lab, you'll create an Azure AD Group for AKS Admins. These "admins" will be the designated users who can access the AKS cluster using kubectl.

## 🛠️ Create Azure AD AKS Admin Group

### Prerequisites
- [ ] Sufficient permissions to create Azure AD groups


### Steps

1. **Run the Script**
   Execute the following command in your terminal:
   ```bash
   ./scripts/create-azure-ad-group.sh
   ```
2. What the Script Does

    The script performs these actions:
    - [ ] Creates an Azure AD Group named `devopsthehardway-aks-group`
    - [ ] Adds the current user (logged into Az CLI) to the `devopsthehardway-aks-group`
    - [ ] Outputs the Azure AD Group ID

**Important Note**
Make sure to note down the Azure AD Group ID displayed at the end of the script execution. You'll need this for AKS Terraform configurations later.

## 🧠 Knowledge Check
After running the script, consider these questions:
1. Why is it beneficial to use Azure AD groups for AKS admin access?
2. How does this group-based access improve security compared to individual user access?
3. In what ways might you further modify the AD group for different levels of access?

## 🔍 Verification
To ensure the group was created successfully:
1. Log into the [Azure Portal](https://portal.azure.com)
2. Navigate to **Azure Active Directory > Groups**
3. Search for `devopsthehardway-aks-group`
4. Verify that your user account is listed as a member:

![Azure-AD-Group](images/azure-ad-group.png)

## 💡 Pro Tip
Consider setting up multiple AD groups with different levels of access (e.g., read-only, developer, admin) to implement a more granular access control strategy for your AKS clusters.
