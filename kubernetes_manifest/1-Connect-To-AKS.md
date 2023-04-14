# Connecting To Elastic Kubernetes Service (AKS)

When you're deploying locally, without any CI/CD to AKS, you'll need to authenticate from your local terminal.

Once you authenticate to AKS from your local terminal, a `kubeconfig` gets stored on your computer. The `kubeconfig` has all of the connection information and authentication needs to connect to AKS.

## Connecting To AKS

1. Get credentials for connection to the AKS:
`az aks get-credentials --resource-group devopsthehardway-rg --name devopsthehardwayaks`

2. Convert credentials to format understood by kubelogin:
`kubelogin convert-kubeconfig -l azurecli`

3. You should now be able to run commands like the following to confirm you can communicate with the AKS:
`kubectl get nodes`