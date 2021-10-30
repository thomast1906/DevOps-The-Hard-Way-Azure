terraform {
  backend "azurerm" {
    resource_group_name  = "rg-devops-hard"
    storage_account_name = "sadevopshard88392"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}