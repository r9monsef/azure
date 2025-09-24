# variable "location" {
#   type        = string
#   description = "Azure region"
# }

# variable "resource_group_name" {
#   type        = string
#   description = "Resource group to deploy into"
# }

# variable "storage_account_name" {
#   type        = string
#   description = "Name of the storage account"
# }

# variable "file_share_name" {
#   type        = string
#   default     = "nginx"
#   description = "Name of the Azure File Share"
# }

# variable "file_share_quota" {
#   type        = number
#   default     = 50
#   description = "Quota in GB for the file share"
# }

# variable "container_app_environment_name" {
#   type        = string
#   description = "Name of the Container App Environment"
# }

# variable "environment_storage_name" {
#   type        = string
#   description = "Name of the storage mount in the environment (used in volume.storage_name)"
# }

# variable "containers" {
#   type = map(object({
#     name         = string
#     image        = string
#     cpu          = number
#     memory       = string
#     min_replicas = number
#     max_replicas = number
#     mount_volume = bool
#     volume_name  = string
#     storage_name = string
#     mount_path   = string
#   }))
#   description = "Map of container configurations"
#   default     = {}
# }


variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group to deploy into"
}

variable "storage_account_name" {
  type        = string
  description = "Name of the shared storage account"
}

variable "container_app_environment_name" {
  type        = string
  description = "Name of the Container App Environment"
}

variable "containers" {
  type = map(object({
    name                      = string
    image                     = string
    cpu                       = number
    memory                    = string
    min_replicas              = number
    max_replicas              = number
    mount_volume              = bool
    volume_name               = string
    environment_storage_name  = string  
    file_share_name           = string  
    file_share_quota          = number  
    mount_path                = string
    expose_internet           = bool
    port                      = optional(number, null)
    ingress_transport         = string
    allowed_source_ips        = list(string)
  }))
  description = "Map of container configurations, each with its own file share"
  default     = {}
}