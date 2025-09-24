# modules/network/variables.tf
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

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space of the virtual network"
  type        = list(string)
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
