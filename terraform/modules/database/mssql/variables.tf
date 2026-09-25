variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "subnet_id" {
  type        = string
  description = "The ID of the subnet where Private Endpoint will be created"
}

variable "config" {
  type = object({
    server_name            = string
    database_name          = string
    administrator_login    = string
    administrator_password = string

    server_version = string

    minimum_tls_version           = string
    public_network_access_enabled = bool

    sku_name             = string
    max_size_gb          = number
    storage_account_type = string

    collation      = string
    zone_redundant = bool

    subnet_key = string

    tags = map(string)
  })
}
