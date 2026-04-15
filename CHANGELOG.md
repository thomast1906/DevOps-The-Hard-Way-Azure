# Changelog

All notable changes to this project will be documented in this file.

## [2026-04-15] - AKS Version Upgrade

### Changed
- **Kubernetes version**: Updated from 1.33 to 1.35



### Changed
- **Terraform**: Required version bumped from `>= 1.9.8` to `>= 1.14.0, < 2.0.0`; pinned to `1.14.8` in CI workflows
- **Azure provider (azurerm)**: Updated from `>= 4.28.0` to `>= 4.68.0, < 5.0.0` across all modules
- **GitHub Actions**:
  - `actions/checkout`: v4 → v6
  - `azure/login`: v2 → v3
  - `azure/setup-kubectl`: v4 → v5
  - `azure/setup-helm`: v4 → v5
  - `docker/setup-buildx-action`: v3 → v4
  - `hashicorp/setup-terraform`: v3 → v4
  - `stefanzweifel/git-auto-commit-action`: v5 → v7
- **Flask**: 3.0.3 → 3.1.3
- **Werkzeug**: 3.0.4 → 3.1.8

### Fixed
- `scripts/deploy-all.sh`: Resolved path-resolution bug where all `cd` calls were relative to the working directory rather than the repo root, causing failures from step 2 onwards. Script now computes `REPO_ROOT` from its own location and uses absolute paths throughout.
- `scripts/deploy-all.sh`: `terraform init` now passes `-backend-config` flags matching the dynamic `${PROJECT_NAME}` storage account, consistent with the GitHub Actions workflow.
- `scripts/deploy-all.sh`: Fixed deprecated `--query objectId` → `--query id` for Azure AD group creation.

### Documentation
- `Test-lab-only.md`: Rewritten with accurate version table, AKS version verification step, environment variable reference, and step-by-step description of what the deploy script does.
- `2-Terraform-AZURE-Services-Creation/README.md` and `1-Create-ACR.md`: Updated Terraform version prerequisite references.

## [2025-07-28] - Major Update

### Added
- Kubernetes health checks and readiness probes to deployment manifest
- Auto-scaling configuration for AKS cluster (min: 1, max: 5 nodes)
- Azure availability zones support for improved resilience
- Network policy support for enhanced security
- Automatic upgrade channel for patch updates
- Enhanced resource limits for better performance

### Changed
- **Kubernetes version**: Updated from 1.32 to 1.33
- **Terraform version**: Updated from 1.11.0 to 1.9.8
- **Azure provider**: Updated from 4.27.0 to 4.28.0+
- **Python base image**: Updated from 3.12-slim to 3.13-slim
- **Flask**: Updated from 2.3.3 to 3.0.3
- **Werkzeug**: Updated from 2.3.8 to 3.0.4
- **ALB Controller**: Updated from 1.0.0 to 1.7.9
- **tfsec GitHub Action**: Updated from v1.2.0 to v1.3.0
- **terraform-docs GitHub Action**: Updated from @main to v1.3.0
- **Checkov**: Pinned to specific version 3.2.4 for consistency

### Enhanced
- **AKS Configuration**:
  - Enabled Azure RBAC for improved security
  - Added automatic scaling capabilities
  - Configured network policies for better security
  - Added availability zones for high availability
  - Improved network configuration with DNS and service CIDR

- **Container Configuration**:
  - Increased memory limits from 256Mi to 512Mi
  - Increased CPU limits from 250m to 500m
  - Added liveness and readiness probes
  - Updated container image tag from v1 to v2

- **CI/CD Pipeline**:
  - Enhanced GitHub Actions workflow with latest action versions
  - Added proper commit user email for auto-commit action
  - Updated Terraform version management

### Security Improvements
- Enabled Azure RBAC on AKS cluster for enhanced role-based access control
- Added network policies for better pod-to-pod communication security
- Updated all dependencies to latest secure versions
- Enhanced container security with health checks

### Documentation Updates
- Updated all version references throughout documentation
- Enhanced README with version information table
- Improved setup instructions with latest tool versions
- Added comprehensive changelog for tracking changes

## Previous Versions
- Initial release with Kubernetes 1.32, Terraform 1.11.0, and Python 3.12
