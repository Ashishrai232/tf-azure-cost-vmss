variable "tags" {
  description = "A map of tags to apply to all resources."
  type        = map(string)
  default = {
    environment = "development"
  }
}


# ********** resource group - variables *********

variable "resource_group_name" {
    type  = "string"
    description = "the name which will be used for this resource group. new will be created "
  
}

variable "resource_group_location" {
    type  = "string"
    description = "the location  which will be used for this resource group. new will be created "
  
}



# *****************variables for vnet


variable "vnet-address_space" {
  type = list(string)
  description = "* this contains the address space"
  default = [ "10.0.0.0/16" ]
}
