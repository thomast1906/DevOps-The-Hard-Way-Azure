# Create The Kubernetes Manifest

Once you've successfully created a Docker image from the Uber app and stored it in Azure Container Registry (ACR), the next step is to configure the Kubernetes manifest for deploying the application to Azure Kubernetes Service (AKS).

## Understanding the Manifest

The Kubernetes manifest comprises three key components:

- The Deployment: This component manages the application's deployment within Kubernetes.
- The Service: Responsible for exposing the Kubernetes application, allowing access from external sources such as load balancer hostnames or IPs.
- Namespace: A mechanism for organizing and isolating resources within a Kubernetes cluster, enabling resource scoping.

The manifest `deployment.yml` can be found in the `kubernetes_manifest` directory. Ensure to update the image URL on line 39 to match the image stored in your Azure account before applying the manifest.