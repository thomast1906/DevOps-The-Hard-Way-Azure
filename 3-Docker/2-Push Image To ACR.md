# Push Image To Azure Container Registry (ACR)

## 🎯 Purpose
In this lab, you'll push the Docker image you created locally to Azure Container Registry (ACR).

## 🛠️ Push Docker Image to ACR

### Prerequisites
- [ ] Docker image created locally
- [ ] Access to an Azure Container Registry

### Steps

1. **Log Into the ACR Repository**

> 🔍 **Note**: Replace `devopsthehardwayazurecr` with your actual ACR name.

   ```bash
   az acr login --name devopsthehardwayazurecr
   ```

2. **Tag the Docker Image**

> 🔍 **Note**: Ensure to replace` devopsthehardwayazurecr` with your ACR name and `v1` with the appropriate version tag if needed.

   ```bash
   docker tag thomasthorntoncloud devopsthehardwayazurecr.azurecr.io/thomasthorntoncloud:v1
   ```
3. **Push the Docker Image to ACR**

   ```bash
   docker push devopsthehardwayazurecr.azurecr.io/thomasthorntoncloud:v1
   ```

## 🧠 Knowledge Check

After pushing the image to ACR, consider these questions:
1. Why do we need to tag the Docker image before pushing it to ACR?
2. What's the significance of the version tag (e.g., `v1`) in the image name?
3. How does ACR authentication work when pushing images?

## 🔍 Verification

To ensure the Docker image was successfully pushed to ACR:
1. Log into the [Azure Portal](https://portal.azure.com).
2. Navigate to your Azure Container Registry
3. Check the "Repositories" section to see if your image is listed:

![](images/acr.png)

## 💡 Pro Tip

Consider setting up CI/CD pipelines to automatically build and push your Docker images to ACR whenever you make changes to your application code.