#  flow
#   Azure resource group - Azure Virtual Network - Azure subnet - Azure public IP 
# ------created the above in network module-----
#   Azure Load Balancer - Azure network interface -
# network interface load balancer backend address pool association 
#   Azure Linux Virtual Machine 
#   Azure NAT Gateway 


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