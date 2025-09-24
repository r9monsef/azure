resource "azurerm_subnet" "subnet" {
  for_each = {
    for k, v in var.subnets :
    k => v
    if !(k == "AzureBastionSubnet" )
  }

  name                 = each.value.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.v-net.name
  address_prefixes     = each.value.address_prefixes
}


