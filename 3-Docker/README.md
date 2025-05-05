# Docker for the DevOps-The-Hard-Way-Azure Project

## Overview
This directory contains everything needed to build, run, and deploy the Docker container for the thomasthornton.cloud application, a simple Flask-based web application. The containerization process demonstrates best practices for creating efficient, secure, and production-ready Docker images.

## Contents

- [Creating the Docker Image](./1-Create-Docker-Image.md) - Learn how to build and run the Docker image locally
- [Pushing to Azure Container Registry](./2-Push%20Image%20To%20ACR.md) - Learn how to push your Docker image to Azure Container Registry
- [Docker Best Practices for Azure](./3-Docker-Best-Practices-For-Azure.md) - Learn about Docker best practices specifically for Azure environments

## Directory Structure

```
.
├── Dockerfile              # Instructions for building the Docker image
├── app/                    # Application source code directory
│   ├── app.py              # Flask application entrypoint
│   ├── index.html          # Web application HTML template
│   └── requirements.txt    # Python dependencies
├── images/                 # Screenshots and documentation images
└── scripts/                # Automation scripts
    └── build-push-acr.sh   # Script to build and push image to ACR
```

## Application Details

This is a simple Flask web application that:

- Serves a responsive HTML page
- Uses a clean and modern UI
- Provides links to the GitHub repository

## Key Improvements

This implementation includes several improvements over basic Docker setups:

1. **Multi-stage builds** for smaller, more secure production images
2. **Non-root user execution** to enhance security
3. **Health checks** for better monitoring and orchestration
4. **Optimized layer caching** for faster builds
5. **Automated build and push script** for consistent deployments
6. **Security scanning** to identify vulnerabilities

## Automation Scripts

The repository includes scripts to automate Docker workflows:

```bash
# Build and push to ACR
cd 3-Docker
chmod +x scripts/build-push-acr.sh
./scripts/build-push-acr.sh <your-acr-name> [optional-tag]

# Scan Docker image for vulnerabilities
chmod +x scripts/scan-docker-image.sh
./scripts/scan-docker-image.sh thomasthorntoncloud:latest
```

## Azure Integration

This Docker container is designed to be deployed to Azure using:

- Azure Container Registry (ACR) for image storage
- Azure Kubernetes Service (AKS) for orchestration
- GitHub Actions for CI/CD pipelines

## Next Steps

After working through the documentation in this folder:

1. Review the [AKS Deployment section](../4-kubernetes_manifest/README.md) to learn how to deploy this application to Azure Kubernetes Service
2. Explore the [Terraform Static Code Analysis](../5-Terraform-Static-Code-Analysis/1-Checkov-For-Terraform.md) to implement security scanning for your infrastructure code

