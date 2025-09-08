output "resource_group_id" {
  value = azurerm_resource_group.test-vmss.id
}

output "location" {
  value = data.azurerm_network_security_group.example.location
}

output "vnet_name" {
  description = "The name of the Virtual Network."
  value       = azurerm_virtual_network.vnet.name
}

output "subnet_id" {
  description = "The ID of the subnet for the VMSS."
  value       = azurerm_subnet.subnet.id
}
