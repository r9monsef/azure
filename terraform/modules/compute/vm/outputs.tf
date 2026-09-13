output "private_ip_address" {
  description = "The private IP address of the virtual machine"
  value       = azurerm_linux_virtual_machine.this.private_ip_address
}