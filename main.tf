# first creating the network 

module "network" {
  source                  = "./modules/network"
  resource_group_location = var.location
  resource_group_name     = var.location
  tags                    = var.tags
}

# now creating the load balancer

module "load_balancer" {
  source                  = "./modules/load_balancer"
  resource_group_name     = module.network.resource_group_name
  resource_group_location = module.network.resource_group_location
  tags                    = var.tags
}

#now finally creating the vmss as now i  have both vnet-subnet-id and 
# load balancer - backend pool ids and 

module "VMSS-creation" {
  source                = "./modules/vmss"
  resource_group_name   = module.network.resource_group_name
  location              = module.network.resource_group_location
  admin_public_key_path = "vmss.pub"
  backend_pool_ids      = module.load_balancer.backend_address_pool_id

  subnet_id             = module.network.subnet_id
  user_data_script_path = "userfile.sh"

  vmss_name = "${var.resource_group_name}-vmss"
  tags      = var.tags
}