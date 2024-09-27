# Create The Kubernetes Manifest

## 🎯 Purpose
In this lab, you'll create and understand the Kubernetes manifest for deploying the Thomasthornton.cloud app to Azure Kubernetes Service (AKS).

## 🛠️ Create and Configure the Kubernetes Manifest

### Prerequisites
- [ ] Docker image created and stored in Azure Container Registry (ACR)
- [ ] Access to your AKS cluster
- [ ] Basic understanding of Kubernetes concepts

### Steps

1. **Understand the Manifest Components**
   The Kubernetes manifest consists of three key components:
   - [ ] Deployment: Manages the application's deployment within Kubernetes
   - [ ] Service: Exposes the Kubernetes application for external access
   - [ ] Namespace: Organises and isolates resources within the cluster

2. **Locate the Manifest File**
   Find the `deployment.yml` file in the `4-kubernetes_manifest` directory.

3. **Update the Image URL**
   Open `deployment.yml` and locate line 24. Update the image URL to match the image stored in your Azure Container Registry.

## 🔍 Verification
To ensure your manifest is correctly configured:
1. Review the entire `deployment.yml` file for any syntax errors
2. Verify that the image URL matches your ACR repository
3. Check that the resource requests and limits are appropriate for your application

## 🧠 Knowledge Check
After reviewing the manifest, consider these questions:
1. What is the purpose of each component (Deployment, Service, Namespace) in the manifest?
2. Why is it important to update the image URL in the manifest?
3. How does the manifest help in managing your application in Kubernetes?

## 🚀 Next Steps
With your Kubernetes manifest prepared, you're ready to deploy your application to AKS. In the next lab, we'll cover how to apply this manifest to your cluster.

## 💡 Pro Tip
Consider using Helm charts for more complex applications. Helm allows you to template your Kubernetes manifests, making it easier to manage multiple environments or similar applications.


