resource "azurerm_virtual_network" "cmwVNET" {
  name =  "${var.Prefix}-vNet"
  location = azurerm_resource_group.cmwK8SRG.location
  resource_group_name = azurerm_resource_group.cmwK8SRG.name
  address_space = [var.Network_ip]
}

resource "azurerm_subnet" "cmwK8s_subnet" {
  name = "${var.Prefix}-k8sSubnet"
  resource_group_name  = azurerm_resource_group.cmwK8SRG.name
  virtual_network_name = azurerm_virtual_network.cmwVNET.name
  address_prefixes = [var.K8sSubnet_ip]
}

resource "azurerm_subnet" "cmwApp_gwsubnet" {
  name = "${var.Prefix}-appSubnet"
  resource_group_name  = azurerm_resource_group.cmwK8SRG.name
  virtual_network_name = azurerm_virtual_network.cmwVNET.name
  address_prefixes = [var.AppSubnet_ip]
}