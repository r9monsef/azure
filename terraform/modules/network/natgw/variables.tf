variable "name" {
  description = "NAT Gateway name"
  type        = string
}

variable "public_ip_name" {
  description = "Public IP name for NAT Gateway"
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

variable "tags" {
  description = "Tags map"
  type        = map(string)
  default     = {}
}

variable "subnet_id" {
  description = "Subnet ID to associate with NAT Gateway"
  type        = string
}
