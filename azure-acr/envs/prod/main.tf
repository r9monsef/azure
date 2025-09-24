module "network" {
  source                   = "../../modules/network"
  location                 = var.location
  resource_group_name      = var.resource_group_name
  subscription_id          = var.subscription_id
  vnet_name                = var.vnet_name
  vnet_address_space       = var.vnet_address_space
  nsgs                     = var.nsgs
  subnet_nsg_associations  = var.subnet_nsg_associations
  nsg_rules                = var.nsg_rules
  subnets                  = var.subnets
}

module "containers" {
  source = "../../modules/containers"

  location                        = var.location
  resource_group_name             = var.resource_group_name
  storage_account_name            = var.storage_account_name
  container_app_environment_name  = var.container_app_environment_name
  containers                      = var.containers
}