terraform {
  backend "azurerm" {
    resource_group_name  = "NetworkWatcherRG"
    storage_account_name = "test12vmss"
    container_name       = "tfstate1"
    key                  = "prod.terraform.tfstate"
  }
}