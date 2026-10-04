resource "azurerm_storage_account" "this" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  account_kind             = var.account_kind
  is_hns_enabled           = var.is_hns_enabled

  public_network_access_enabled = var.public_network_access_enabled

  network_rules {
    default_action = var.network_rules_default_action
    ip_rules       = []
    virtual_network_subnet_ids = []
  }

  tags = var.tags
}

resource "azurerm_storage_container" "containers" {
  for_each              = var.containers
  name                  = each.key
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = each.value.container_access_type
}

resource "azurerm_storage_share" "fileshares" {
  for_each             = var.file_shares
  name                 = each.key
  storage_account_name = azurerm_storage_account.this.name
  quota                = try(each.value.quota_in_gb, 50)
  access_tier          = try(each.value.access_tier, "TransactionOptimized")
}

resource "azurerm_private_endpoint" "pe" {
  for_each            = var.private_endpoints
  name                = "pe-${azurerm_storage_account.this.name}-${each.value.subresource_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = each.value.subnet_id

  private_service_connection {
    name                           = "psc-${azurerm_storage_account.this.name}-${each.value.subresource_name}"
    private_connection_resource_id = azurerm_storage_account.this.id
    is_manual_connection           = false
    subresource_names              = [each.value.subresource_name]
  }

  dynamic "private_dns_zone_group" {
    for_each = each.value.private_dns_zone_id != null ? [1] : []
    content {
      name                 = "default"
      private_dns_zone_ids = [each.value.private_dns_zone_id]
    }
  }

  tags = var.tags
}
