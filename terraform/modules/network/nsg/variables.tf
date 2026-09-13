variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

# variable "security_rules" {
#   type = list(object({
#     name                       = string
#     priority                   = number
#     direction                  = string
#     access                     = string
#     protocol                   = string
#     source_port_range          = string
#     destination_port_range     = string
#     source_address_prefix      = string
#     destination_address_prefix = string
#   }))
# }

variable "tags" {
  description = "Tags to apply to the NSG"
  type        = map(string)
  default     = {}
}


variable "security_rules" {
  type = list(object({
    name                        = string
    priority                    = number
    direction                   = string
    access                      = string
    protocol                    = string
    source_port_range           = string
    destination_port_range      = optional(string)
    destination_port_ranges     = optional(list(string))
    source_address_prefix       = string
    destination_address_prefix  = string
  }))
}