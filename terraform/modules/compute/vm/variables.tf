variable "name" {}
variable "location" {}
variable "resource_group_name" {}
variable "subnet_id" {}

variable "public_ip_enabled" { type = bool }


variable "vm_size" {
  type        = string
  description = "VM size (e.g. Standard_D2s_v3)"
}

variable "disk_type" {
  type        = string
  description = "OS disk storage account type (e.g. StandardSSD_LRS)"
}

variable "disk_size_gb" {
  type        = number
  description = "OS disk size in GB"
}

variable "admin_ssh_public_keys" {
  type = list(string)
}

variable "admin_username" {
  type        = string
  description = "Linux admin username"
}


variable "image" {
  description = "Image configuration for Ubuntu or other OS"
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
}

variable "tags" {
  type = map(string)
}

variable "role" {
  type    = string
  default = "generic"
}

variable "features" {
  type = object({
    nginx   = optional(bool, false)
    docker  = optional(bool, false)
    monitor = optional(bool, false)
  })
}