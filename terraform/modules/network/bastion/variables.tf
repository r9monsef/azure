variable "name" {
  description = "Name of the Bastion Host"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "subnet_id" {
  description = "ID of AzureBastionSubnet"
  type        = string
}


variable "zones" {
  description = "Availability Zones"
  type        = list(string)
  default     = ["1", "2", "3"]
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}
