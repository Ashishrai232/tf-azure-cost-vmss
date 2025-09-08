# we will make all the network components of the vmss here, which includes 
# 1. resource group
#     1. location
#     2. name
# 2. vnet
# 3. subnet 
# 4. pip 
# 5. security group
# 6. association

resource azurerm_resource_group "test-vmss"{
    name= var.resource_group_name
    location = var.resource_group_location
    tags = var.tags
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.resource_group_name}-${var.resource_group_location}-vnet"
  location            = azurerm_resource_group.test-vmss.location
  resource_group_name = azurerm_resource_group.test-vmss.name
  address_space       = ["10.0.0.0/16"] 
  tags = var.tags
}

resource "azurerm_subnet" "vnet-subnet" {
  name="${azurerm_virtual_network.vnet.name}-${var.tags.environment}-subnet"
  resource_group_name = azurerm_resource_group.test-vmss.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = ["10.0.2.0/24"]
}

# now creating public ip for load balancer
# sku =Standard because it is must for attaching it to load balancer
resource "azurerm_public_ip" "pip" {
  name="${azurerm_virtual_network.vnet.name}-${var.tags.environment}-alb-pip"
  location = var.resource_group_location
  resource_group_name = azurerm_resource_group.test-vmss.name
  allocation_method = "Static"
  sku = "Standard"
  tags=var.tags
} 

resource "azurerm_network_security_group" "nsg" {
  name = "${azurerm_virtual_network.vnet.name}-${var.tags.environment}-vmss-nsg"
  resource_group_name = azurerm_resource_group.test-vmss.name
  location = azurerm_resource_group.test-vmss.location
  tags = var.tags

  security_rule{
     name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg-association" {
  subnet_id = azurerm_subnet.vnet-subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}