resource "azurerm_storage_account" "st" {
  name                     = var.storage_account_name
  location                 = var.location
  resource_group_name      = var.resource_group_name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "per_container" {
  for_each           = var.containers
  name               = each.value.file_share_name
  storage_account_id = azurerm_storage_account.st.id
  quota              = each.value.file_share_quota
}

resource "azurerm_container_app_environment" "env" {
  name                = var.container_app_environment_name
  location            = var.location
  resource_group_name = var.resource_group_name

  workload_profile {
    name                  = "Consumption"
    workload_profile_type = "Consumption"
  }
}

resource "azurerm_container_app_environment_storage" "per_share" {
  for_each                     = var.containers
  name                         = each.value.environment_storage_name
  container_app_environment_id = azurerm_container_app_environment.env.id
  account_name                 = azurerm_storage_account.st.name
  access_key                   = azurerm_storage_account.st.primary_access_key
  access_mode                  = "ReadWrite"
  share_name                   = azurerm_storage_share.per_container[each.key].name
}

resource "azurerm_container_app" "this" {
  for_each                     = var.containers
  name                         = each.value.name
  resource_group_name          = var.resource_group_name
  container_app_environment_id = azurerm_container_app_environment.env.id
  revision_mode                = "Single"

  dynamic "ingress" {
    for_each = each.value.port != null ? [1] : []
    content {
      external_enabled = each.value.expose_internet
      target_port      = each.value.port
      transport        = each.value.ingress_transport

      traffic_weight {
        percentage = 100
        latest_revision = true
      }
    }
  }

  template {
    container {
      name   = each.value.name
      image  = each.value.image
      cpu    = each.value.cpu
      memory = each.value.memory

      dynamic "volume_mounts" {
        for_each = each.value.mount_volume ? [1] : []
        content {
          name = each.value.volume_name
          path = each.value.mount_path
        }
      }
    }

    dynamic "volume" {
      for_each = each.value.mount_volume ? [1] : []
      content {
        name         = each.value.volume_name
        storage_name = each.value.environment_storage_name
        storage_type = "AzureFile"
      }
    }

    min_replicas = each.value.min_replicas
    max_replicas = each.value.max_replicas
  }

  depends_on = [
    azurerm_container_app_environment_storage.per_share
  ]
}