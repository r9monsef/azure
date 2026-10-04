variable "storage_account_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "account_tier" {
  type    = string
  default = "Standard"
}

variable "account_replication_type" {
  type    = string
  default = "LRS"
}

variable "account_kind" {
  type    = string
  default = "StorageV2"
}

variable "is_hns_enabled" {
  type    = bool
  default = false
}

variable "public_network_access_enabled" {
  type    = bool
  default = true
}

variable "network_rules_default_action" {
  type    = string
  default = "Allow"
}

variable "allowed_ip_ranges" {
  type    = list(string)
  default = []
}

variable "allowed_subnet_ids" {
  type    = list(string)
  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "private_endpoints" {
  type = map(object({
    subnet_id           = string
    subresource_name    = string
    private_dns_zone_id = optional(string)
  }))
  default = {}
}

variable "containers" {
  type = map(object({
    container_access_type = optional(string, "private")
  }))
  default = {}
}

variable "file_shares" {
  type = map(object({
    quota_in_gb = optional(number, 50)
    access_tier = optional(string, "Hot")
  }))
  default = {}
}
