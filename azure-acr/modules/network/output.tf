output "vnet_id" {
  value = azurerm_virtual_network.v-net.id
}

output "subnet_ids" {
  description = "Map of subnet IDs keyed by subnet block key in var.subnets"
  value       = { for k, s in azurerm_subnet.subnet : k => s.id }
}


output "vnet_name" {
  description = "The name of the created Virtual Network"
  value       = azurerm_virtual_network.v-net.name
}

