resource "azurerm_log_analytics_workspace" "cmwLAWorkspace" {
  name                = "${var.Prefix}-k8s-la"
  location            = var.Region
  resource_group_name = azurerm_resource_group.cmwK8SRG.name
  sku                 = "PerGB2018"
}

resource "azurerm_log_analytics_solution" "cmwLAContainerInsights" {
  solution_name         = "ContainerInsights"
  location              = var.Region
  resource_group_name   = azurerm_resource_group.cmwK8SRG.name
  workspace_resource_id = azurerm_log_analytics_workspace.cmwLAWorkspace.id
  workspace_name        = azurerm_log_analytics_workspace.cmwLAWorkspace.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}