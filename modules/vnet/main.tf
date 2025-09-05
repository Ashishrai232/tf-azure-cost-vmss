
resource "azurerm_virtual_network" "example" {
  name                = var.vnet-name
  location            = var.vnet-location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet-address_space
  tags = var.tags
}