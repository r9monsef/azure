resource "azurerm_mssql_server" "this" {
  name                = var.config.server_name
  resource_group_name = var.resource_group_name
  location            = var.location
  version             = var.config.server_version

  administrator_login          = var.config.administrator_login
  administrator_login_password = var.config.administrator_password

  minimum_tls_version = var.config.minimum_tls_version

  public_network_access_enabled = var.config.public_network_access_enabled

  tags = var.config.tags
}

resource "azurerm_mssql_database" "this" {
  name      = var.config.database_name
  server_id = azurerm_mssql_server.this.id

  sku_name    = var.config.sku_name
  max_size_gb = var.config.max_size_gb

  storage_account_type = var.config.storage_account_type

  collation      = var.config.collation
  zone_redundant = var.config.zone_redundant

  tags = var.config.tags
}

# اتصال پایگاه داده به ساب‌نت از طریق Private Endpoint
resource "azurerm_private_endpoint" "mssql" {
  name                = "${var.config.server_name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${var.config.server_name}-privateserviceconnection"
    private_connection_resource_id = azurerm_mssql_server.this.id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }

  tags = var.config.tags
}
