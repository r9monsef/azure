locals {
  storage_accounts = {
    rezateststgacc = {
      name                          = "rezateststgacc"
      account_tier                  = "Standard"
      account_replication_type      = "LRS"
      account_kind                  = "StorageV2"
      public_network_access_enabled = true
      network_rules_default_action  = "Allow"
      private_endpoints = {
        blob = {
          subresource_name = "blob"
        }
        file = {
          subresource_name = "file"
        }
      }
    }
  }
}
