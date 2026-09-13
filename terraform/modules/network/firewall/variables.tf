variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "firewall_subnet_id" {
  type = string
}

variable "management_subnet_id" {
  type = string
}

variable "sku_name" {
  type    = string
  default = "AZFW_VNet"
}

variable "sku_tier" {
  type    = string
  default = "Basic"
}

variable "threat_intel_mode" {
  type    = string
  default = "Alert"
}

variable "dns_proxy_enabled" {
  type    = bool
  default = true
}

variable "dns_servers" {
  type    = list(string)
  default = []
}

variable "rule_collection_group_priority" {
  type    = number
  default = 100
}

variable "tags" {
  type    = map(string)
  default = {}
}


variable "network_rule_collections" {
  type    = any
  default = []
}

variable "application_rule_collections" {
  type    = any
  default = []
}

