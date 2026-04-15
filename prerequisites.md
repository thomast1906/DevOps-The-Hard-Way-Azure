# 📋 Prerequisites - Interactive Learning Setup

> **⏱️ Setup Time:** 30-45 minutes | **💡 One-time setup for the entire tutorial series**

## 🎯 **Learning Path Overview**

This prerequisites guide ensures you have everything needed for the **11 interactive tutorials** in this comprehensive DevOps learning platform. Each tutorial includes validation steps, troubleshooting guides, and hands-on practice scenarios.

## 💼 **Professional DevOps Background**

### **📚 Required Experience Level**

**🎯 This is an intermediate-to-advanced tutorial series.** Success requires:

**✅ Cloud Engineering Foundation:**
- [ ] **Azure fundamentals** - Understanding of basic Azure services and concepts
- [ ] **Infrastructure concepts** - Compute, networking, storage, and security principles
- [ ] **Previous cloud projects** - Hands-on experience with cloud deployments

**✅ Development & Automation Skills:**
- [ ] **Scripting proficiency** - Bash, PowerShell, or Python automation experience
- [ ] **Version control** - Git workflows and collaborative development
- [ ] **Command-line comfort** - Terminal/CLI operations and troubleshooting

**✅ Infrastructure & Operations:**
- [ ] **System administration** - Linux/Windows server management experience
- [ ] **Network fundamentals** - VPNs, firewalls, load balancers, DNS
- [ ] **Storage systems** - Understanding of different storage types and use cases

**✅ Previous Roles (Recommended):**
- Systems Administrator, Infrastructure Engineer, Cloud Engineer, Site Reliability Engineer, or similar technical operations role

> **💡 New to DevOps?** Consider completing Azure fundamentals training and gaining basic cloud experience before starting this advanced tutorial series.

## ☁️ **Azure Account & Subscription Setup**

### **🏗️ Azure Account Requirements**

1. **🔐 Create Azure Account**
   - **Free Account:** [Sign up for 12-month free trial](https://azure.microsoft.com/free/)
   - **Existing Account:** Verify active subscription with sufficient credits
   - **Organization Account:** Ensure Contributor or Owner permissions

2. **💰 Cost Planning & Budgets**
   
   **📊 Expected Costs by Environment:**
   - **💡 Learning/Development:** $50-100/month (recommended for this tutorial)
   - **🚀 Production-equivalent:** $200-500/month
   - **⚡ Minimal testing:** $20-50/month (with aggressive cleanup)

   **💡 Cost Management Tips:**
   - Set up [Azure budgets and alerts](https://docs.microsoft.com/en-us/azure/cost-management-billing/costs/tutorial-acm-create-budgets)
   - Use [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator/) for estimates
   - Delete resources immediately after tutorials if cost is a concern
   - Consider [Azure Dev/Test pricing](https://azure.microsoft.com/pricing/dev-test/) if eligible

3. **🔒 Security & Governance Setup**
   ```bash
   # Verify your Azure permissions
   az role assignment list --assignee $(az account show --query user.name -o tsv) --output table
   
   # Should see Contributor or Owner role
   ```

## 🛠️ **Required Software Installation**

### **☁️ Azure CLI - Primary Interface**

**🎯 Purpose:** Command-line interface for all Azure operations throughout the tutorials.

```bash
# Installation verification
az --version
az login
az account show --output table
```

**📦 Installation Options:**
- **Windows:** [Azure CLI Installer](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows)
- **macOS:** `brew install azure-cli`
- **Linux:** [Package manager installation](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux)

### **💻 Code Editor - Development Environment**

**🎯 Recommended:** [Visual Studio Code](https://code.visualstudio.com/download) with extensions:

**📦 Essential VS Code Extensions:**
- **Azure Account** - Azure integration and authentication
- **Azure Terraform** - Terraform syntax highlighting and validation
- **Docker** - Container management and Dockerfile editing
- **Kubernetes** - YAML validation and cluster management
- **YAML** - Enhanced YAML editing for Kubernetes manifests

### **🏗️ Terraform - Infrastructure as Code**

**🎯 Version Requirement:** v1.9.8 or higher

```bash
# Verify installation
terraform --version
# Should show: Terraform v1.9.8 or higher
```

**📦 Installation:**
- **Download:** [Terraform Downloads](https://www.terraform.io/downloads.html)
- **macOS:** `brew install terraform`
- **Windows:** Use Chocolatey or manual download
- **Linux:** Package manager or manual installation

**⚙️ Configuration:**
```bash
# Verify Terraform can access Azure
terraform init
terraform providers
```

### **🐳 Docker - Containerization Platform**

**🎯 Purpose:** Container creation, testing, and local development.

**📦 Installation Options:**
- **Docker Desktop:** [Download for Windows/macOS](https://www.docker.com/products/docker-desktop)
- **Linux:** [Install Docker Engine](https://docs.docker.com/engine/install/)

**✅ Verification:**
```bash
# Test Docker installation
docker --version
docker run hello-world

# Verify Docker can build images
docker build --help
```

### **☸️ Kubernetes Tools - Cluster Management**

**🎯 kubectl - Kubernetes command-line tool**

**📦 Installation:** [Install kubectl](https://kubernetes.io/docs/tasks/tools/)

```bash
# Verify installation
kubectl version --client
# Should show version 1.35.x or compatible
```

**🔐 kubelogin - Azure authentication plugin**

**📦 Installation:** [Azure/kubelogin](https://github.com/Azure/kubelogin)

```bash
# Verify installation
kubelogin --version

# Test Azure integration
az aks get-credentials --help
```

### **🔍 Source Control - Version Management**

**🎯 GitHub Account Setup**

1. **📝 Create Account:** [GitHub.com](https://github.com)
2. **🔐 Configure Authentication:**
   ```bash
   # Configure Git
   git config --global user.name "Your Name"
   git config --global user.email "your.email@example.com"
   
   # Verify GitHub access
   git clone https://github.com/thomast1906/DevOps-The-Hard-Way-Azure.git
   ```

3. **🚀 GitHub CLI (Optional but Recommended):**
   ```bash
   # Install GitHub CLI
   # macOS: brew install gh
   # Windows: winget install GitHub.cli
   
   # Authenticate
   gh auth login
   ```

## 🔧 **Advanced Tools Setup (Required for Complete Experience)**

### **🐍 Python Environment**

**🎯 Version:** Python 3.13 or higher for application understanding and automation.

```bash
# Verify Python installation
python3 --version
pip3 --version

# Install virtual environment support
pip3 install virtualenv
```

### **🛡️ Security Scanning Tools**

**🔍 Checkov - Infrastructure Security Scanner**

```bash
# Install Checkov
pip3 install checkov==3.2.4

# Verify installation
checkov --version
checkov --help
```

**🔒 tfsec - Terraform Security Scanner** *(Optional but Recommended)*

```bash
# macOS installation
brew install tfsec

# Manual installation
# Download from: https://github.com/aquasecurity/tfsec/releases

# Verify installation
tfsec --version
```

### **📖 Documentation Automation**

**📚 terraform-docs - Documentation Generator**

```bash
# macOS installation
brew install terraform-docs

# Manual installation
# Download from: https://github.com/terraform-docs/terraform-docs/releases

# Verify installation
terraform-docs --version
```

## ✅ **Pre-Tutorial Validation**

**🔧 Complete System Check**

Run this comprehensive validation script to ensure everything is properly configured:

```bash
#!/bin/bash
echo "🔍 DevOps Learning Platform - System Validation"
echo "=============================================="

# Check Azure CLI
if command -v az &> /dev/null; then
    echo "✅ Azure CLI: $(az --version | head -n1)"
    if az account show &> /dev/null; then
        echo "✅ Azure Authentication: Active"
    else
        echo "❌ Azure Authentication: Please run 'az login'"
    fi
else
    echo "❌ Azure CLI: Not installed"
fi

# Check Terraform
if command -v terraform &> /dev/null; then
    echo "✅ Terraform: $(terraform --version | head -n1)"
else
    echo "❌ Terraform: Not installed"
fi

# Check Docker
if command -v docker &> /dev/null; then
    echo "✅ Docker: $(docker --version)"
    if docker ps &> /dev/null; then
        echo "✅ Docker Service: Running"
    else
        echo "⚠️ Docker Service: Not running"
    fi
else
    echo "❌ Docker: Not installed"
fi

# Check kubectl
if command -v kubectl &> /dev/null; then
    echo "✅ kubectl: $(kubectl version --client --short)"
else
    echo "❌ kubectl: Not installed"
fi

# Check Python
if command -v python3 &> /dev/null; then
    echo "✅ Python: $(python3 --version)"
else
    echo "❌ Python3: Not installed"
fi

# Check Checkov
if command -v checkov &> /dev/null; then
    echo "✅ Checkov: $(checkov --version)"
else
    echo "⚠️ Checkov: Not installed (recommended for security tutorials)"
fi

echo ""
echo "🎯 Validation complete! Review any ❌ items before starting tutorials."
```

## 🚀 **Learning Environment Setup**

### **📂 Workspace Organization**

```bash
# Create organized workspace
mkdir -p ~/devops-learning
cd ~/devops-learning

# Clone the tutorial repository
git clone https://github.com/thomast1906/DevOps-The-Hard-Way-Azure.git
cd DevOps-The-Hard-Way-Azure

# Verify tutorial structure
ls -la
```

### **🔧 Environment Variables** *(Optional but Helpful)*

```bash
# Add to your shell profile (.bashrc, .zshrc, etc.)
export AZURE_RESOURCE_GROUP="devopsthehardway-rg"
export AZURE_LOCATION="uksouth"
export TUTORIAL_PATH="$HOME/devops-learning/DevOps-The-Hard-Way-Azure"

# Source your profile
source ~/.zshrc  # or ~/.bashrc
```

## 🎓 **Next Steps - Begin Your DevOps Journey**

**✅ Prerequisites Complete?** Start with the foundation tutorials:

1. **🗄️ [Configure Terraform Remote Storage](1-Azure/1-Configure-Terraform-Remote-Storage.md)** *(10-15 min)*
2. **👥 [Create Azure AD Group for AKS Admins](1-Azure/2-Create-Azure-AD-Group-AKS-Admins.md)** *(8-12 min)*

**📚 Learning Tips:**
- **Follow sequentially** - Each tutorial builds on the previous
- **Use validation scripts** - Verify your progress at each step
- **Practice troubleshooting** - Read error messages and use provided solutions
- **Take breaks** - Complex topics benefit from reflection time
- **Document your journey** - Keep notes for future reference

**🚀 Ready to transform your DevOps skills?** [Start with the foundation setup!](1-Azure/1-Configure-Terraform-Remote-Storage.md)

### Additional Tools (Optional but Recommended)

#### Python
Python 3.13 or higher for running automation scripts and understanding the sample application.
[Python Downloads](https://www.python.org/downloads/)

#### Checkov
Static analysis tool for infrastructure as code security scanning.
```bash
pip install checkov==3.2.4
```

#### tfsec
Security scanner for Terraform code.
```bash
# macOS
brew install tfsec

# Or download from GitHub releases
# https://github.com/aquasecurity/tfsec/releases
```

#### terraform-docs
Generate documentation from Terraform modules.
```bash
# macOS
brew install terraform-docs

# Or download from GitHub releases
# https://github.com/terraform-docs/terraform-docs/releases
```
