# Create an Azure resource group using azurerm_resource_group 
# Create an Azure Virtual Network using azurerm_virtual_network
# Create an Azure subnet using azurerm_subnet
# Create an Azure public IP using azurerm_public_ip
# ------created the above in network module-----
# Create an Azure Load Balancer using azurerm_lb
# Create an Azure network interface using azurerm_network_interface
# Create an Azure network interface load balancer backend address pool association using azurerm_network_interface_backend_address_pool_association
# Create an Azure Linux Virtual Machine using azurerm_linux_virtual_machine
# Create an Azure Virtual Machine Extension using azurerm_virtual_machine_extension
# Create an Azure NAT Gateway using azurerm_nat_gateway
# Create an Azure Bastion using azurerm_bastion_host


# pip will be applied to load balancer hence creating it here



resource "azurerm_public_ip" "example" {
  name                = "PublicIPForLB"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku = "Standard"
}

resource "azurerm_lb" "example" {
  name                = "TestLoadBalancer"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.example.id
  }

}
resource "azurerm_lb_backend_address_pool" "example" {
  loadbalancer_id = azurerm_lb.example.id
  name            = "BackEndAddressPool"
}

resource "azurerm_lb_rule" "example" {
  loadbalancer_id                = azurerm_lb.example.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.example.id]
}