terraform {
  backend "azurerm" {
    resource_group_name  = "ChristopherRG"
    storage_account_name = "christophersa"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}


provider "azurerm" {
  version = "~> 2.0"
  features {}
}