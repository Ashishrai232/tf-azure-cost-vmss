
variable "vnet-location"{
    type = string
    description = "* this will contain location"
}
variable "vnet-address_space" {
  type = list(string)
  description = "* this contains the address space"
  default = [ "10.0.0.0/16" ]
}

variable "vnet-name" {
    type = string
    description = "* this contains vnet name - which will be reflected on account"
}

variable "resource_group_name" {
  type = string
  description = "* this describes name of resource group "
}

variable "tags" {
  type=map(string)
}