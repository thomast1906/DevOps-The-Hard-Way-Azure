module "aks" {
  source                           = "Azure/aks/azurerm"
  resource_group_name              = azurerm_resource_group.rg.name
  #client_id                        = "your-service-principal-client-appid"
  #client_secret                    = "your-service-principal-client-password"
  kubernetes_version               = var.kubernetes_version
  orchestrator_version             = var.kubernetes_version
  prefix                           = var.name
  cluster_name                     = "aks-cluster"
  network_plugin                   = "azure"
  vnet_subnet_id                   = azurerm_subnet.aks_subnet.id
  os_disk_size_gb                  = 64
  sku_tier                         = "Free" # defaults to Free
  enable_role_based_access_control = true
  rbac_aad_admin_group_object_ids  = [var.aks_admins_group_object_id]
  rbac_aad_managed                 = true
  private_cluster_enabled          = false # default value
  enable_http_application_routing  = true
  enable_azure_policy              = true
  enable_auto_scaling              = true
  enable_host_encryption           = false
  agents_min_count                 = 1
  agents_max_count                 = 2
  agents_count                     = null # Please set `agents_count` `null` while `enable_auto_scaling` is `true` to avoid possible `agents_count` changes.
  agents_max_pods                  = 100
  agents_pool_name                 = "nodepool01"
  agents_availability_zones        = ["1", "2"]
  agents_type                      = "VirtualMachineScaleSets"

  agents_labels = {
    "nodepool" : "defaultnodepool"
  }

  agents_tags = {
    "Agent" : "defaultnodepoolagent"
  }

  network_policy                 = "azure"
  net_profile_dns_service_ip     = "10.0.0.10"
  net_profile_docker_bridge_cidr = "170.10.0.1/16"
  net_profile_service_cidr       = "10.0.0.0/16"

  depends_on = [azurerm_resource_group.rg]
}