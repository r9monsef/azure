variable "name" {
  description = "Name of the Application Gateway"
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

variable "subnet_id" {
  description = "Subnet ID dedicated to the Application Gateway"
  type        = string
}

variable "backend_ips" {
  description = "List of private IP addresses for the backend pool"
  type        = list(string)
}

variable "frontend_port" {
  type    = number
  default = 80
}

variable "backend_port" {
  type    = number
  default = 80
}

variable "tags" {
  type    = map(string)
  default = {}
}