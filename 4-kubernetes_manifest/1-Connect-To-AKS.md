# Connecting To Azure Kubernetes Service (AKS)

## 🎯 Purpose
In this lab, you'll learn how to authenticate and connect to your Azure Kubernetes Service (AKS) cluster from your local terminal.

## 🛠️ Connect to AKS Cluster

### Prerequisites
- [ ] kubectl installed on your local machine
- [ ] Access to an AKS cluster

### Steps

1. **Authenticate and Connect to AKS**
   Run the following command to connect to AKS:
   ```bash
   az aks get-credentials --resource-group devopsthehardway-rg --name devopsthehardwayaks --overwrite-existing
   ```

> 🔍 **Note**: Note: This command generates a kubeconfig file on your local machine with the necessary connection and authentication details.

2. Verify Connection
   Run the following command to confirm you're connected:
   ```bash
   kubectl get nodes
   ```
## 🔍 Verification

To ensure you've successfully connected to your AKS cluster:
1. The `kubectl get nodes` command should return a list of nodes without any errors.
2. You should be able to run other kubectl commands, such as `kubectl get pods --all-namespaces`.

## 🧠 Knowledge Check

After connecting to AKS, consider these questions:
1. What is a `kubeconfig` file and why is it important?
2. How does the `az aks get-credentials` command facilitate cluster access?
3. What other kubectl commands can you use to verify your connection to the cluster?

## 💡 Pro Tip

Consider setting up different contexts in your kubeconfig file if you're working with multiple Kubernetes clusters. This allows you to switch between clusters easily using the `kubectl config use-context` command.
