resource "azurerm_resource_group" "cmwK8SRG" {
  name     = "${var.Prefix}-RG"
  location = var.Region
}

