# tfsec For Terraform Security Scanning

## 🎯 Purpose
In this lab, you'll learn how to use tfsec, a static analysis security scanner for your Terraform code, and integrate it into your GitHub Actions workflow for automated security checks.

## 🛠️ Install and Run tfsec

### Prerequisites
- [ ] Basic understanding of Terraform
- [ ] GitHub repository with Terraform code
- [ ] Permissions to update GitHub Actions workflows

### Steps

1. **Install tfsec Locally**
   
   Install tfsec using one of the following methods:

   **Homebrew (macOS/Linux)**:
   ```bash
   brew install tfsec
   ```

   **Docker**:
   ```bash
   docker run --rm -it -v "$(pwd):/src" aquasec/tfsec /src
   ```

   **Go**:
   ```bash
   go install github.com/aquasecurity/tfsec/cmd/tfsec@latest
   ```

   **Chocolatey (Windows)**:
   ```bash
   choco install tfsec
   ```

2. **Run tfsec Locally**

   Run tfsec against your Terraform code:
   ```bash
   tfsec /path/to/terraform/code
   ```

   For example:
   ```bash
   tfsec DevOps-The-Hard-Way-Azure/2-Terraform-Azure-services-creation/4-aks
   ```

3. **Add tfsec to GitHub Actions Workflow**

   Open your GitHub Actions workflow file (`.github/workflows/main.yml`) and add the tfsec action:

   ```yaml
   - name: tfsec
     uses: aquasecurity/tfsec-pr-commenter-action@v1.2.0
     with:
       tfsec_args: --soft-fail
       github_token: ${{ github.token }}
   ```

   The `--soft-fail` argument ensures the workflow doesn't fail when security issues are found, but still reports them as comments on your PR.

4. **Understanding tfsec Results**

   tfsec checks include:
   - [ ] Insecure security group rules
   - [ ] Unencrypted resources
   - [ ] Public exposure of sensitive resources
   - [ ] Missing logging configurations
   - [ ] IAM misconfigurations
   - [ ] Azure-specific security best practices

## 🔍 Verification

To ensure tfsec is working correctly:
1. Run tfsec locally to see immediate results
2. Create a pull request with Terraform code changes
3. Verify that tfsec is adding security-related comments to your PR
4. Review and address the issues identified

Example tfsec output:

```
  Results:
    HIGH: Resource 'azurerm_storage_account.storage' uses unencrypted storage for account 'mystorageaccount'
    Impact: Data could be read if compromised
    Resolution: Enable encryption for storage accounts
      More info: https://aquasecurity.github.io/tfsec/v1.28.0/checks/azure/storage/encrypt-in-transit/
      File: ./storage.tf:Line:1:Column:1
```

## 🧠 Knowledge Check

After integrating tfsec, consider these questions:
1. How does tfsec differ from Checkov in its approach to security scanning?
2. What are the benefits of having security checks integrated directly into the PR process?
3. How would you handle false positives in tfsec findings?
4. What is the significance of the `--soft-fail` flag in the GitHub Action?

## 💡 Pro Tips

1. **Customise Checks with .tfsec.yml**
   
   Create a `.tfsec.yml` file in your repository root to customise which checks to include or exclude:

   ```yaml
   exclude:
     # Exclude a specific check
     - azure-storage-use-secure-tls-policy
   
   # Set minimum severity level
   minimum_severity: MEDIUM
   ```

2. **Generate a Baseline**

   If you have existing issues that you want to ignore temporarily:

   ```bash
   tfsec --soft-fail --out=tfsec.baseline ./path/to/code
   ```

   Then use the baseline in future scans:

   ```bash
   tfsec --baseline tfsec.baseline ./path/to/code
   ```

3. **Output Formats**

   tfsec supports multiple output formats for CI/CD integration:

   ```bash
   # JSON output
   tfsec --format=json ./path/to/code
   
   # SARIF format (for GitHub Code Scanning)
   tfsec --format=sarif ./path/to/code
   
   # JUnit format (for test reporting)
   tfsec --format=junit ./path/to/code
   ```
