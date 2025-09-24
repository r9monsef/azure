output "container_ids" {
  value = { for k, v in azurerm_container_app.this : k => v.id }
}

output "container_names" {
  value = { for k, v in azurerm_container_app.this : k => v.name }
}