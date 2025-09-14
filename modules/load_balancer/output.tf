# outputs.tf

output "load_balancer_id" {
  description = "The ID of the Azure Load Balancer."
  value       = azurerm_lb.example.id
}

output "backend_address_pool_id" {
  description = "The ID of the backend address pool, which is needed to attach virtual machines."
  value       = azurerm_lb_backend_address_pool.example.id
}

output "public_ip_address" {
  description = "The public IP address assigned to the Load Balancer's frontend."
  value       = azurerm_public_ip.example.ip_address
}

output "frontend_ip_configuration_id" {
  description = "The ID of the frontend IP configuration."
  value       = azurerm_lb.example.frontend_ip_configuration[0].id
}