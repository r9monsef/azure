# modules/network/nsg.tf
resource "azurerm_network_security_group" "nsg" {
  for_each            = var.nsgs
  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  for_each = var.subnet_nsg_associations

  subnet_id                 = azurerm_subnet.subnet[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.value].id
}
resource "azurerm_network_security_rule" "nsg_rules" {
  for_each = {
    for rule_obj in flatten([
      for nsg_key, rules in var.nsg_rules : [
        for rule in rules : merge(rule, { nsg_key = nsg_key })
      ]
    ]) :
    "${rule_obj.nsg_key}-${rule_obj.name}" => rule_obj
  }

  name                       = each.value.name
  priority                   = each.value.priority
  direction                  = each.value.direction
  access                     = each.value.access
  protocol                   = each.value.protocol
  source_port_range          = each.value.source_port_range
  destination_port_range     = each.value.destination_port_range
  source_address_prefix      = each.value.source_address_prefix
  destination_address_prefix = each.value.destination_address_prefix

  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg[each.value.nsg_key].name
}
