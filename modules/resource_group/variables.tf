variable "resource_group_name" {
    type  = "string"
    description = "the name which will be used for this resource group. new will be created "
  
}

variable "resource_group_location" {
    type  = "string"
    description = "the location  which will be used for this resource group. new will be created "
  
}

variable "tags" {
  type=map(string)
}