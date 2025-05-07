# Terraform Documentation Automation

## Overview
This directory contains instructions for implementing automated documentation generation for Terraform code using terraform-docs and GitHub Actions. Proper documentation is a critical aspect of infrastructure as code that is often overlooked but can greatly improve collaboration and maintenance.

## Labs in this Section

### [1. Set Up Terraform-docs with GitHub Actions](./1-Setup-Terraform-Docs.md)
Learn how to automate the creation and maintenance of Terraform documentation using terraform-docs and GitHub Actions.

## Features and Benefits

- Automated documentation generation on every pull request
- Consistent documentation format across all Terraform code
- Documentation that stays in sync with your infrastructure code
- Improved developer experience and onboarding
- Enhanced collaboration through better documentation

## Integration with DevOps Workflow

The terraform-docs tool integrates seamlessly with your existing DevOps workflow:

1. Developers write or update Terraform code
2. A pull request is created
3. GitHub Actions automatically generates or updates documentation
4. Documentation changes are committed back to the PR
5. Reviewers can see both code and documentation changes together
6. The PR is merged with complete, up-to-date documentation

## Best Practices Applied

- Documentation as code
- Automated processes to ensure consistency
- Integration with existing CI/CD pipelines
- Standardised format for better readability
- Version-controlled documentation that evolves with your code
