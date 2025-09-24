# envs/prod/variables.tf
variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group to deploy resources into"
  type        = string
}

variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
  default     = ""
}

variable "client_id" {
  description = "Azure client (application) ID"
  type        = string
  default     = ""
}

variable "client_secret" {
  description = "Azure client secret"
  type        = string
  sensitive   = true
  default     = ""
}

variable "subnets" {
  description = "Subnets for the VNet"
  type = map(object({
    name             = string
    address_prefixes = list(string)
  }))
  default = {}
}

variable "nsgs" {
  description = "Map of NSGs to create by key"
  type = map(object({
    name = string
  }))
  default = {}
}

variable "subnet_nsg_associations" {
  description = "Maps subnet keys to NSG keys"
  type        = map(string)
  default     = {}
}

variable "nsg_rules" {
  description = "Map of NSG keys to lists of security rules"
  type = map(list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  })))
  default = {}
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space of the virtual network"
  type        = list(string)
}

variable "storage_account_name" {
  type = string
}


variable "container_app_environment_name" {
  type = string
}


variable "containers" {
  type = map(object({
    name         = string
    image        = string
    cpu          = number
    memory       = string
    min_replicas = number
    max_replicas = number
    mount_volume = bool
    volume_name  = string
    environment_storage_name  = string   
    file_share_name           = string  
    file_share_quota          = number  
    mount_path   = string
    expose_internet           = bool       
    ingress_transport         = string
    port                      = number      
    allowed_source_ips        = list(string)
  }))
  description = "Map of container configurations to deploy"
  default     = {}
}
