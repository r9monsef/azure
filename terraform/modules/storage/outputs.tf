output "id" {
  description = "The ID of the storage account"
  value       = azurerm_storage_account.this.id
}

output "name" {
  value = azurerm_storage_account.this.name
}

output "primary_blob_endpoint" {
  value = azurerm_storage_account.this.primary_blob_endpoint
}

output "primary_file_endpoint" {
  value = azurerm_storage_account.this.primary_file_endpoint
}

output "private_endpoint_ips" {
  value = {
    for key, endpoint in azurerm_private_endpoint.pe :
    key => endpoint.private_service_connection[0].private_ip_address
  }
}
