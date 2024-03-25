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
  role_definition_name = "contributor"
  depends_on = [
    azurerm_kubernetes_cluster.k8s,
    azurerm_user_assigned_identity.alb_identity
  ]
}

resource "azurerm_role_assignment" "appgwcontainernode" {
  principal_id         = azurerm_user_assigned_identity.alb_identity.principal_id
  scope                = data.azurerm_resource_group.node_resource_group.id
  role_definition_name = "contributor"
  depends_on = [
    azurerm_kubernetes_cluster.k8s,
    azurerm_user_assigned_identity.alb_identity
  ]
}

#fixing for  "The client '62119122-6287-4620-98b4-bf86535e2ece' with object id '62119122-6287-4620-98b4-bf86535e2ece' does not have authorization to perform action 'Microsoft.ServiceNetworking/register/action' over scope '/subscriptions/XXXXX' or the scope is invalid. (As part of App Gw for containers - maanged by ALB controller setup)"
data "azurerm_subscriptions" "thomasthorntoncloud" {
  display_name_contains = var.subscriptionName
}

resource "azurerm_role_assignment" "appgwcontainerfix" {
  principal_id         = azurerm_user_assigned_identity.alb_identity.principal_id
  scope                = data.azurerm_subscriptions.thomasthorntoncloud.subscriptions[0].id
  role_definition_name = "Network Contributor"
  depends_on = [
    azurerm_kubernetes_cluster.k8s,
    azurerm_user_assigned_identity.alb_identity
  ]
}
