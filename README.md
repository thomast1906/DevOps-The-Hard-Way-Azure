# DevOps the Hard Way on Azure

Welcome to the DevOps the Hard Way on Azure tutorial! 🚀

This comprehensive guide provides a real-world solution for implementing DevOps practices and technologies to deploy applications and cloud services/infrastructure on Microsoft Azure.

## 🌟 What's Inside?

- Free labs
- Detailed documentation
- Step-by-step guides

All designed to help you set up a complete DevOps environment from a real-world perspective in Azure.

## 🎭 The DevOps Scenario

Imagine this: You've just joined a company stuck in the past. They're drowning in:
- [ ] Bare metal servers
- [ ] Manual deployments
- [ ] Outdated IT practices

> **Your mission, should you choose to accept it:**  
> Modernize everything. Make the organisation not just succeed, but lead the pack.

## 💡 The DevOps Solution

We're going to deploy the thomasthornton.cloud application, transforming it from a bare-metal application to a DevOps masterpiece. 

![](images/website.png)

> 🔍 **Note**: As a DevOps/Platform Engineer, your focus is on deployment, not application development. That's why we're using an existing app for this tutorial.

## 🛠️ Technology Stack

Get ready to utilise a range of cutting-edge technologies and platforms to establish your DevOps environment:

| Technology | Purpose |
|------------|---------|
| Azure | Cloud hosting and services |
| GitHub | Code repository |
| Python | Application and automation |
| Terraform | Infrastructure as Code |
| Docker | Containerization |
| Kubernetes (AKS) | Container orchestration |
| GitHub Actions | CI/CD |
| Checkov | Automated testing |

## 🧪 Labs

[ ] Check boxes have been added to each lab to help you keep track of your progress.

### Prerequisites

Before you start, ensure you have the following [prerequisites](https://github.com/thomast1906/DevOps-The-Hard-Way-Azure/blob/main/prerequisites.md) in place
1. [ ] [Create a Storage Account for Terraform State file](https://github.com/thomast1906/DevOps-The-Hard-Way-Azure/blob/main/1-Azure/1-Configure-Terraform-Remote-Storage.md)
2. [ ] [Set up an Azure AD Group for AKS Admins](https://github.com/thomast1906/DevOps-The-Hard-Way-Azure/blob/main/1-Azure/2-Create-Azure-AD-Group-AKS-Admins.md)

### Main Sections

1. **Terraform** - Create all the Azure cloud services needed to run the thomasthorntoncloud application.
    - [ ] [Create Azure Container Registry (ACR)](https://github.com/thomast1906/DevOps-The-Hard-Way-Azure/blob/main/Terraform-AZURE-Services-Creation/1-Create-ACR.md)
    - [ ] [Create Azure Virtual Network (VNET)](https://github.com/thomast1906/DevOps-The-Hard-Way-Azure/blob/main/Terraform-AZURE-Services-Creation/2-Create-VNET.md)
    - [ ] [Create Log Analytics](https://github.com/thomast1906/DevOps-The-Hard-Way-Azure/blob/main/Terraform-AZURE-Services-Creation/3-Create-Log-Analytics.md)
    - [ ] [Create AKS Cluster with relevant IAM roles](https://github.com/thomast1906/DevOps-The-Hard-Way-Azure/blob/main/Terraform-AZURE-Services-Creation/4-Create-AKS-Cluster-IAM-Roles.md)

2. **Docker** - Containerise the thomasthorntoncloud application and store it in Azure Container Registry (ACR).
    - [ ] [Create the Docker Image](https://github.com/thomast1906/DevOps-The-Hard-Way-Azure/blob/main/3-Docker/1-Create-Docker-Image.md)
    - [ ] [Create a Docker Image for the thomasthorntoncloud App](https://github.com/thomast1906/DevOps-The-Hard-Way-Azure/blob/main/3-Docker/Push%20Image%20To%20ACR.md)


3. **Kubernetes** - Deploy application to AKS and expose the thomasthorntoncloud application to the internet.
    - [ ] [Connect To AKS From The Terminal](https://github.com/thomast1906/DevOps-The-Hard-Way-Azure/blob/main/4-kubernetes_manifest/1-Connect-To-ACR.md)
    - [ ] [Create A Kubernetes Manifest](https://github.com/thomast1906/DevOps-The-Hard-Way-Azure/blob/main/4-kubernetes_manifest/2-Create-Kubernetes-Manifest.md)
    - [ ] [Deploy thomasthorntoncloud App into Kubernetes](https://github.com/thomast1906/DevOps-The-Hard-Way-Azure/blob/main/4-kubernetes_manifest/3-Deploy-Uber-App.md)


4. **Automated Testing** Ensure code quality
    - [ ] [Install And Run Checkov](https://github.com/thomast1906/DevOps-The-Hard-Way-Azure/blob/main/Terraform-Static-Code-Analysis/1-Checkov-For-Terraform.md)


5. **CICD** - Automatically update AKS cluster with CICD using GitHub Actions
    - [ ] [Create a GitHub Actions CICD pipeline](https://github.com/thomast1906/DevOps-The-Hard-Way-Azure/blob/main/Terraform-AZURE-Services-Creation/5-Run-CICD-For-AKS-Cluster.md)

## 🎓 Learning Checkpoints

After each section, test your understanding:

```markdown
- [ ] Can you explain why we're using a remote state for Terraform?
- [ ] What's the significance of containerizing the app?
- [ ] How does AKS simplify Kubernetes management?
- [ ] Why is automated testing crucial in a DevOps pipeline?
- [ ] How does CI/CD improve the deployment process?
```

## Conclusion
By following this tutorial, you'll not only deploy an example app on Azure but also gain valuable insights into modern DevOps practices and tools. 

Let's embark on this journey to transform your organization into a lean, agile, and competitive force in the digital landscape. Happy deploying! 🚀🔧

- By completing this tutorial, you'll:
- Deploy a real-world app on Azure
- Master essential DevOps tools and practices
- Transform your organisation's IT landscape

Are you ready to embark on this DevOps journey? Let's turn that monolithic infrastructure into a lean, mean, deploying machine! 💪🚀 📣 

I value your feedback! If you find any issues or have suggestions for improvement, please open an issue or submit a pull request.
