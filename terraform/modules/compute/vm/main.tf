locals {
  scripts_base_path = "${path.root}/../../scripts"

  common_script  = fileexists("${local.scripts_base_path}/base/common.sh") ? file("${local.scripts_base_path}/base/common.sh") : "# no common script"
  nginx_script   = fileexists("${local.scripts_base_path}/web/nginx.sh") ? file("${local.scripts_base_path}/web/nginx.sh") : "# no nginx script"
  docker_script  = fileexists("${local.scripts_base_path}/container/docker.sh") ? file("${local.scripts_base_path}/container/docker.sh") : "# no docker script"
  monitor_script = fileexists("${local.scripts_base_path}/monitoring/node-exporter.sh") ? file("${local.scripts_base_path}/monitoring/node-exporter.sh") : "# no monitor script"
}

resource "azurerm_public_ip" "this" {
  count               = var.public_ip_enabled ? 1 : 0
  name                = "${var.name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_network_interface" "this" {
  name                = "${var.name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_enabled ? azurerm_public_ip.this[0].id : null
  }

  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.vm_size

  admin_username                  = var.admin_username
  disable_password_authentication = true

  network_interface_ids = [
    azurerm_network_interface.this.id
  ]
custom_data = base64encode(templatefile("${path.module}/cloud-init.tpl", {

  common_script  = indent(6, local.common_script)
  nginx_script   = indent(6, local.nginx_script)
  docker_script  = indent(6, local.docker_script)
  monitor_script = indent(6, local.monitor_script)

  nginx_enabled   = try(var.features.nginx, false)
  docker_enabled  = try(var.features.docker, false)
  monitor_enabled = try(var.features.monitor, false)

}))

  os_disk {
    name                 = "${var.name}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = var.disk_type
    disk_size_gb         = var.disk_size_gb
  }

  source_image_reference {
    publisher = var.image.publisher
    offer     = var.image.offer
    sku       = var.image.sku
    version   = var.image.version
  }

  dynamic "admin_ssh_key" {
    for_each = var.admin_ssh_public_keys

    content {
      username   = var.admin_username
      public_key = admin_ssh_key.value
    }
  }

  tags = var.tags
}