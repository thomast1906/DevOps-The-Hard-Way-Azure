# Set Up Terraform-docs with GitHub Actions

## 🎯 Purpose
In this lab, you'll learn how to automate Terraform documentation using terraform-docs and GitHub Actions. This ensures your infrastructure documentation is always up-to-date and consistent.

## 🛠️ Setting Up Terraform-docs

### Prerequisites
- [ ] GitHub repository with Terraform code
- [ ] GitHub Actions workflow set up
- [ ] Permissions to modify GitHub workflow files

### Steps

1. **Understand terraform-docs**
   
   Terraform-docs is a utility tool that automatically generates documentation from Terraform modules. It extracts:
   - Inputs (variables)
   - Outputs
   - Providers
   - Requirements
   - Resources
   - And more

   This documentation is generated in various formats, including Markdown, which we'll use to inject into our README files.

2. **Add terraform-docs GitHub Action**

   - Open your GitHub Actions workflow file (`.github/workflows/main.yml`) 
   - Add the terraform-docs action:

   ```yaml
   - name: Render terraform docs and push changes back to PR
     uses: terraform-docs/gh-actions@main
     with:
       working-dir: .
       output-file: README.md
       output-method: inject
       git-push: "true"
   ```

3. **Prepare Your README.md Files**

   - For each Terraform module where you want documentation generated, open or create a README.md file
   - Add the terraform-docs markers where you want the documentation inserted:

   ```markdown
   <!-- BEGIN_TF_DOCS -->
   <!-- END_TF_DOCS -->
   ```

   These markers tell terraform-docs where to inject the generated documentation.

4. **Test the Workflow**

   - Make a change to your Terraform code
   - Create a pull request
   - The GitHub Action will automatically run and update your README.md files with generated documentation
   - The changes will be pushed back to the same PR

## 🔍 Verification

To ensure terraform-docs is working correctly:
1. Create a pull request with a change to Terraform code
2. Wait for the GitHub Action to complete
3. Check that the README.md files have been updated with documentation between the markers
4. Verify that the documentation accurately reflects your Terraform code

Example of generated documentation:

```
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| azurerm | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 3.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource_group_name | Name of the resource group | `string` | n/a | yes |
| location | Azure region for resources | `string` | `"uksouth"` | no |

## Outputs

| Name | Description |
|------|-------------|
| acr_id | ID of the Azure Container Registry |
```

## 🧠 Knowledge Check

After setting up terraform-docs, consider these questions:
1. Why is automated documentation important for infrastructure as code?
2. How does terraform-docs determine what to include in the documentation?
3. What are the benefits of injecting documentation into README files versus maintaining separate docs?
4. How can terraform-docs improve collaboration in a team environment?

## 💡 Pro Tips

1. **Customising Output Format**

   You can customise the output format using a `.terraform-docs.yml` file in your repository root:

   ```yaml
   formatter: "markdown table"
   
   sections:
     show:
       - requirements
       - providers
       - inputs
       - outputs
       - resources
   
   output:
     file: README.md
     mode: inject
     template: |-
       <!-- BEGIN_TF_DOCS -->
       {{ .Content }}
       <!-- END_TF_DOCS -->
   ```

2. **Module-Specific Configuration**

   For different documentation in different modules, create module-specific configuration files:

   ```
   my-terraform-project/
   ├── .terraform-docs.yml  # Default config
   ├── module1/
   │   ├── .terraform-docs.yml  # Module-specific config
   │   └── README.md
   └── module2/
       └── README.md
   ```

3. **Configure Which Files to Document**

   In your GitHub workflow, specify which directories to document:

   ```yaml
   with:
     working-dir: |
       terraform/module1
       terraform/module2
     output-file: README.md
     output-method: inject
     git-push: "true"
   ```

4. **Pre-Commit Hook for Local Development**

   Install terraform-docs locally and set up a pre-commit hook to maintain documentation during development:

   ```bash
   # Install terraform-docs (macOS)
   brew install terraform-docs
   
   # Run manually
   terraform-docs markdown table --output-file README.md --output-mode inject ./my-module
   ```

5. **Adding Diagrams**

   Consider enhancing your documentation with architecture diagrams using tools like [Terraform Graph](https://github.com/offu/terraform-graph):

   ```bash
   terraform graph | dot -Tsvg > graph.svg
   ```

   Then include the SVG in your README.md outside the terraform-docs markers.
