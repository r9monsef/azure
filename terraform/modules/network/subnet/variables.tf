variable "subnet_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "virtual_network_name" {
  type = string
}

variable "address_prefixes" {
  type = list(string)
}

variable "private_endpoint_network_policies_enabled" {
  type    = bool
  default = true
}

variable "private_link_service_network_policies_enabled" {
  type    = bool
  default = true
}

variable "service_endpoints" {
  type    = list(string)
  default = []
}

variable "nsg_id" {
  type    = string
  default = null
}

variable "attach_nsg" {
  type    = bool
  default = false
}
