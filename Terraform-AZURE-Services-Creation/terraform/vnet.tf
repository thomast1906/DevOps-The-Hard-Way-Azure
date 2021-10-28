resource "azurerm_virtual_network" "virtual_network" {
  name =  "vnet-${var.name}"
  location = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space = [var.network_address_space]
}

resource "azurerm_subnet" "aks_subnet" {
  name = var.aks_subnet_address_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes = [var.aks_subnet_address_prefix]
}

resource "azurerm_subnet" "app_gwsubnet" {
  name = var.subnet_address_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes = [var.subnet_address_prefix]
}