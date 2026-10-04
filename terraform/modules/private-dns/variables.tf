variable "resource_group_name" {
  type = string
}

variable "vnet_id" {
  type = string
}

variable "dns_zones" {
  type = map(object({
    name = string
  }))
}

variable "tags" {
  type    = map(string)
  default = {}
}
