# Connecting To Azure Kubernetes Service (AKS)

When deploying locally to Azure Kubernetes Service (AKS) without employing any CI/CD pipelines, you'll need to authenticate from your local terminal.

Upon successful authentication to AKS from your local terminal, a kubeconfig file is generated and stored on your computer. This kubeconfig file contains all the necessary connection information and authentication details required to access AKS.

## Connecting To AKS

1. Run the following command to connect to AKS:
`az aks get-credentials --resource-group devopsthehardway-rg --name devopsthehardwayaks --overwrite-existing`

2. Once connected, you should be able to run commands like the following to confirm you're connected:
`kubectl get nodes`

Running this command should return information about the nodes in your AKS cluster, confirming your successful connection.