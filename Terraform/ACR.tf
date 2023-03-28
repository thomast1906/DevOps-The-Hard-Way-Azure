resource "azurerm_container_registry" "cmwACR" {
  name                = "${var.Prefix}kpaacr"
  resource_group_name = azurerm_resource_group.cmwK8SRG.name
  location            = azurerm_resource_group.cmwK8SRG.location
  sku                 = "Standard"
  admin_enabled       = false
}