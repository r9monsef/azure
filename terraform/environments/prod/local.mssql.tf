locals {
  mssql = {
    server_name   = "srvdbtest"
    database_name = "testdbreza"

    administrator_login    = "azuser"
    administrator_password = "Aa/12345"

    server_version = "12.0"

    minimum_tls_version           = "1.2"
    public_network_access_enabled = false

    # Standard S1 = 20 DTU
    sku_name    = "S1"
    max_size_gb = 30

    # Required by Azure Policy
    storage_account_type = "Local"

    collation      = "SQL_Latin1_General_CP1_CI_AS"
    zone_redundant = false

    subnet_key = "mssql"

    tags = {
      environment = "prod"
      service     = "mssql"
      managed_by  = "terraform"
    }
  }
}