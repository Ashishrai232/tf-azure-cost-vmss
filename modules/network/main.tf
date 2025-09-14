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
  address_space       = var.vnet_address_space
  tags = var.tags
}

resource "azurerm_subnet" "vnet-subnet" {
  name="${azurerm_virtual_network.vnet.name}-${var.tags.environment}-subnet"
  resource_group_name = azurerm_resource_group.test-vmss.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes =var.subnet_address_prefixes
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


  security_rule {
    name                       = "web"
    priority                   = 1080
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = var.subnet_address_prefixes[0]
  }

}

resource "azurerm_subnet_network_security_group_association" "nsg-association" {
  subnet_id = azurerm_subnet.vnet-subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}