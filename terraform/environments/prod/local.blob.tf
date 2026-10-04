locals {
  blob = {
    "rezateststgacc/app-backups" = {
      storage_account_key   = "rezateststgacc"
      container_name        = "app-backups"
      container_access_type = "private"
    }
    "rezateststgacc/logs" = {
      storage_account_key   = "rezateststgacc"
      container_name        = "logs"
      container_access_type = "private"
    }
  }
}
