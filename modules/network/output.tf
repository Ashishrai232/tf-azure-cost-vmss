# outputs.tf

output "resource_group_name" {
  description = "The name of the created resource group."
  value       = azurerm_resource_group.test-vmss.name
}

output "resource_group_location" {
  description = "The location of the created resource group."
  value       = azurerm_resource_group.test-vmss.location
}

output "virtual_network_name" {
  description = "The name of the virtual network."
  value       = azurerm_virtual_network.vnet.name
}

output "subnet_id" {
  description = "The ID of the subnet. This is crucial for attaching network interfaces (e.g., from VMs or VMSS)."
  value       = azurerm_subnet.vnet-subnet.id
}

output "subnet_name" {
  description = "The name of the subnet."
  value       = azurerm_subnet.vnet-subnet.name
}

