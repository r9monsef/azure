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

module "nsgs" {
  source = "../../modules/network/nsg"
  for_each = local.nsgs
  name                = "${each.key}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
  security_rules = concat(each.value.inbound, each.value.outbound)
 # security_rules = each.value
  tags           = var.tags
}#



module "firewall" {
  source               = "../../modules/network/firewall"
  name                 = "fw-prod"
  location             = var.location
  resource_group_name  = var.resource_group_name
  firewall_subnet_id   = module.subnets["firewall"].subnet_id
  management_subnet_id = module.subnets["firewall_mgmt"].subnet_id
  
  network_rule_collections     = local.network_rule_collections
  application_rule_collections = local.application_rule_collections
  tags                         = var.tags
}

module "route_tables" {
  source = "../../modules/network/route-table"

  for_each = local.route_tables

  name                          = each.value.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  disable_bgp_route_propagation = try(each.value.disable_bgp_route_propagation, false)
  routes                        = each.value.routes
  tags                          = var.tags
}


module "mssql" {
  source              = "../../modules/database/mssql"
  config              = local.mssql
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = module.subnets[local.mssql.subnet_key].subnet_id
}
