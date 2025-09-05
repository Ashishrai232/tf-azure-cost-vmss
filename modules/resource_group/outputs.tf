output "resource_group_id" {
  value = azurerm_resource_group.test-vmss.id
}

output "resource_group_location" {
  value = azurerm_resource_group.test-vmss.location
}

output "resource_group_name" {
  value = azurerm_resource_group.test-vmss.name
}