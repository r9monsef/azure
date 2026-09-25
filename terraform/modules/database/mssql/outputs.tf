output "server_id" {
  value = azurerm_mssql_server.this.id
}

output "server_name" {
  value = azurerm_mssql_server.this.name
}

output "server_fqdn" {
  value = azurerm_mssql_server.this.fully_qualified_domain_name
}

output "database_id" {
  value = azurerm_mssql_database.this.id
}

output "database_name" {
  value = azurerm_mssql_database.this.name
}

output "private_endpoint_resource_id" {
  value = azurerm_mssql_server.this.id
}

output "private_endpoint_subresource_names" {
  value = ["sqlServer"]
}

output "subnet_key" {
  value = var.config.subnet_key
}