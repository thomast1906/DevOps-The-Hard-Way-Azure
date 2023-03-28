resource "azurerm_kubernetes_cluster" "cmwk8sCluster" {
  name                = "${var.Prefix}-akscluster"
  location            = var.Region
  resource_group_name = azurerm_resource_group.cmwK8SRG.name
  dns_prefix          = "${var.Prefix}dns"
  kubernetes_version  = "1.23.12"

  node_resource_group = "${var.Prefix}-node-rg"

  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = file("${var.Ssh_PublicKey}")
    }
  }

  default_node_pool {
    name                 = "agentpool"
    node_count           = "1"
    vm_size              = "Standard_DS2_v2"
    vnet_subnet_id       = azurerm_subnet.cmwK8s_subnet.id
    type                 = "VirtualMachineScaleSets"
    orchestrator_version = "1.23.12"
  }

  identity {
    type = "SystemAssigned"
  }

  addon_profile {
    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.cmwLAWorkspace.id
    }

    ingress_application_gateway {
      enabled   = true
      subnet_id = azurerm_subnet.cmwApp_gwsubnet.id
    }

  }

  network_profile {
    load_balancer_sku = "standard"
    network_plugin    = "azure"
  }

  role_based_access_control {
    enabled = true

    azure_active_directory {
      managed                = true
      admin_group_object_ids = [var.Group_Id]
    }
  }
}

# getting the node resource group ID from the aks cluster
data "azurerm_resource_group" "cmwNodeRG" {
  name = azurerm_kubernetes_cluster.cmwk8sCluster.node_resource_group
  depends_on = [
    azurerm_kubernetes_cluster.cmwk8sCluster
  ]
}

resource "azurerm_role_assignment" "cmwScaleSet" {
  principal_id         = azurerm_kubernetes_cluster.cmwk8sCluster.kubelet_identity[0].object_id
  scope                = data.azurerm_resource_group.cmwNodeRG.id
  role_definition_name = "Virtual Machine Contributor"
  depends_on = [
    azurerm_kubernetes_cluster.cmwk8sCluster
  ]
}

resource "azurerm_role_assignment" "cmwACR_pull" {
  principal_id         = azurerm_kubernetes_cluster.cmwk8sCluster.kubelet_identity[0].object_id
  scope                = azurerm_resource_group.cmwK8SRG.id
  role_definition_name = "acrpull"
  depends_on = [
    azurerm_kubernetes_cluster.cmwk8sCluster
  ]
}