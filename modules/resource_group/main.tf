# resource "azurerm_resource_group" "example" {
#   name     = "example"
#   location = "West Europe"
# }

resource azurerm_resource_group "test-vmss"{
    name= var.resource_group_name
    location = var.resource_group_location
    tags = var.tags
}