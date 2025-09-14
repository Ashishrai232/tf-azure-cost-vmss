
variable "subscription_id" {
  description = "to pass your subscription id "
  type = string
}
variable "resource_group_name" {
  description = " name for the resource group and other resources."
  type        = string
  default     = "test-vmss"
}

variable "location" {
  description = "The region where all resources will be deployed."
  type        = string
  default     = "East US"
}


variable "tags" {
  description = "A map of tags to apply to all resources."
  type        = map(string)
  default = {
    environment = "dev"
    project     = "ASHISH-devops"
  }
}