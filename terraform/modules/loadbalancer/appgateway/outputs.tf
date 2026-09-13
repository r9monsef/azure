output "id" {
  description = "Application Gateway ID"
  value       = azurerm_application_gateway.this.id
}

output "frontend_ip" {
  description = "Public IP address of the Application Gateway"
  value       = azurerm_public_ip.this.ip_address
}