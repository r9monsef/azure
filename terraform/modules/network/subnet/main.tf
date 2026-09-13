resource "azurerm_subnet" "this" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.address_prefixes

  private_endpoint_network_policies_enabled     = var.private_endpoint_network_policies_enabled
  private_link_service_network_policies_enabled = var.private_link_service_network_policies_enabled
  service_endpoints                             = var.service_endpoints
}

# resource "azurerm_subnet_network_security_group_association" "this" {
#   count = var.nsg_id != null ? 1 : 0

#   subnet_id                 = azurerm_subnet.this.id
#   network_security_group_id = var.nsg_id
# }

resource "azurerm_subnet_network_security_group_association" "this" {
  count = var.attach_nsg ? 1 : 0

  subnet_id                 = azurerm_subnet.this.id
  network_security_group_id = var.nsg_id
}
