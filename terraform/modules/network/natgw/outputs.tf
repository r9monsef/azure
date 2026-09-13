output "id" {
  description = "NAT Gateway ID"
  value       = azurerm_nat_gateway.this.id
}

output "name" {
  description = "NAT Gateway name"
  value       = azurerm_nat_gateway.this.name
}

output "public_ip_id" {
  description = "Public IP ID attached to NAT Gateway"
  value       = azurerm_public_ip.this.id
}

output "public_ip_address" {
  description = "Public IP address attached to NAT Gateway"
  value       = azurerm_public_ip.this.ip_address
}
