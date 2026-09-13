
module "vnet" {
  for_each = local.vnets
  source   = "../../modules/network/vnet"

  resource_group_name = var.resource_group_name
  location            = var.location

  vnet_name     = each.value.name
  address_space = each.value.address_space
  tags          = var.tags
}

module "subnets" {
  for_each = local.subnets
  source   = "../../modules/network/subnet"

  subnet_name          = each.value.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = module.vnet[each.value.vnet].vnet_name
  address_prefixes     = each.value.address_prefixes

  nsg_id     = try(module.nsgs[each.value.nsg].nsg_id, null)
  attach_nsg = each.value.nsg != null

  private_endpoint_network_policies_enabled     = each.value.private
  private_link_service_network_policies_enabled = !each.value.private
}


module "natgw" {
  source = "../../modules/network/natgw"

  for_each = local.nat_gateways

  name                = each.value.name
  public_ip_name      = each.value.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  subnet_id           = module.subnets[each.value.subnet_key].subnet_id
}



module "vms" {
  source = "../../modules/compute/vm"

  for_each = local.vms

  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group_name

  subnet_id    = module.subnets[each.value.subnet_key].subnet_id
  vm_size      = each.value.vm_size
  disk_size_gb = each.value.disk_size_gb
  disk_type    = each.value.disk_type

  admin_username        = each.value.admin_username
  admin_ssh_public_keys = local.ssh_keys_by_role[each.value.role]
  public_ip_enabled     = each.value.public_ip

  image    = each.value.image
  tags     = var.tags
  role     = each.value.role
  features = lookup(each.value, "features", {})
}

module "nsgs" {

  source = "../../modules/network/nsg"

  for_each = local.nsgs

  name                = "${each.key}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rules = each.value
  tags           = var.tags
}


# module "bastion" {
#   source = "../../modules/network/bastion"

#   name                = "bas-stage"
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   subnet_id           = module.subnets["bastion"].subnet_id

#   tags = var.tags
# }


# module "appgateways" {
#   source = "../../modules/loadbalancer/appgateway"

#   for_each = local.appgateways

#   name                = each.value.name
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   subnet_id           = module.subnets[each.value.subnet_key].subnet_id
#   tags                = var.tags


#   backend_ips = [for vm in module.vms : vm.private_ip_address]

# }