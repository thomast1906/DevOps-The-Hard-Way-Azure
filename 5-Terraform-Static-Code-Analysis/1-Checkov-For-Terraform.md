
# Checkov For Terraform

## 🎯 Purpose
In this lab, you'll learn how to use Checkov, a leading open-source static/security analysis tool, to test and secure your Terraform code.

## 🛠️ Install and Run Checkov

### Prerequisites
- [ ] Python installed
- [ ] Basic understanding of Terraform
- [ ] Terraform code to scan

### Steps

1. **Install Checkov**
   Run one of the following commands:
   ```bash
   pip install checkov
   ```

    OR
    
    ```bash
    pip3 install checkov
    ```

2. **Run Checkov**
    Run the following command in your terminal:
    ```bash
    checkov
    ```
    You'll see a prompt to set up the free Bridgecrew UI. Press `Y` to start the process.

3. **Scan Terraform Code**

    Run the following command to scan the Terraform code:
    ```bash
    checkov --directory <path_to_terraform_code>
    ```

    For example:
    ```bash
    checkov --directory DevOps-The-Hard-Way-Azure/Terraform-AZURE-Services-Creation/1-acr
    ```

## 🔍 Verification

To ensure Checkov is working correctly:
1. Check that the scan completes without errors
2. Review the list of passed and failed tests in the terminal output
3. Verify that you can access the results in the Bridgecrew UI

## 🧠 Knowledge Check

After running Checkov, consider these questions:
1. What types of issues does Checkov identify in Terraform code?
2. How does Checkov differ from other Terraform validation tools?
3. What are the benefits of using the Bridgecrew UI alongside Checkov?

## 💡 Pro Tip

Use Checkov's `--compact flag` to get a more concise output, or `--quiet` to only see failed checks. This can be helpful when integrating with CI/CD pipelines.