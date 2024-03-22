data "azurerm_resource_group" "node_resource_group" {
  name = azurerm_kubernetes_cluster.k8s.node_resource_group
  depends_on = [
    azurerm_kubernetes_cluster.k8s
  ]
}

resource "azurerm_role_assignment" "node_infrastructure_update_scale_set" {
  principal_id         = azurerm_kubernetes_cluster.k8s.kubelet_identity[0].object_id
  scope                = data.azurerm_resource_group.node_resource_group.id
  role_definition_name = "Virtual Machine Contributor"
  depends_on = [
    azurerm_kubernetes_cluster.k8s
  ]
}

data "azurerm_container_registry" "acr" {
  name                = "${var.name}tamopsacr"
  resource_group_name = data.azurerm_resource_group.resource_group.name
}

resource "azurerm_role_assignment" "acr_pull" {
  principal_id         = azurerm_kubernetes_cluster.k8s.kubelet_identity[0].object_id
  scope                = data.azurerm_container_registry.acr.id
  role_definition_name = "acrpull"
  depends_on = [
    azurerm_kubernetes_cluster.k8s
  ]
}

resource "azurerm_role_assignment" "appgwcontainer" {
  principal_id         = azurerm_user_assigned_identity.alb_identity.principal_id
  scope                = data.azurerm_resource_group.resource_group.id
  role_definition_name = "reader"
  depends_on = [
    azurerm_kubernetes_cluster.k8s,
    azurerm_user_assigned_identity.alb_identity
  ]
}

resource "azurerm_role_assignment" "appgwcontainersubnet" {
  principal_id       = azurerm_user_assigned_identity.alb_identity.principal_id
  scope              = data.azurerm_resource_group.resource_group.id
  role_definition_id = "4d97b98b-1d4f-4787-a291-c67834d212e7"
  depends_on = [
    azurerm_kubernetes_cluster.k8s,
    azurerm_user_assigned_identity.alb_identity
  ]
}

resource "azurerm_role_assignment" "appgwcontainernoderg" {
  principal_id       = azurerm_user_assigned_identity.alb_identity.principal_id
  scope              = data.azurerm_resource_group.node_resource_group.id
  role_definition_id = "fbc52c3f-28ad-4303-a892-8a056630b8f1"
  depends_on = [
    azurerm_kubernetes_cluster.k8s,
    azurerm_user_assigned_identity.alb_identity
  ]
}