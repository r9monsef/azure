locals {

  vms = {

    webapp1 = {
      name           = "webapp1"
      vm_size        = "Standard_B2s"
      subnet_key     = "app"
      role           = "web"
      public_ip      = true
      disk_size_gb   = 30
      disk_type      = "Standard_LRS"
      admin_username = "azureuser"
      image = {
        publisher = "Canonical"
        offer     = "ubuntu-24_04-lts"
        sku       = "server"
        version   = "latest"
      }
      features = {
        docker  = false
        nginx   = true
        monitor = false
      }
    }
    webapp2 = {
      name           = "webapp2"
      vm_size        = "Standard_B2s"
      subnet_key     = "app"
      role           = "web"
      public_ip      = true
      disk_size_gb   = 30
      disk_type      = "Standard_LRS"
      admin_username = "azureuser"
      image = {
        publisher = "Canonical"
        offer     = "ubuntu-24_04-lts"
        sku       = "server"
        version   = "latest"
      }
      features = {
        docker  = false
        nginx   = true
        monitor = false
      }
    }


    # db = {
    #   name           = "db"
    #   vm_size        = "Standard_B2s"
    #   subnet_key     = "db"
    #   role           = "db"
    #   public_ip      = false
    #   disk_size_gb   = 30
    #   disk_type      = "Standard_LRS"
    #   admin_username = "azureuser"
    #   image = {
    #     publisher = "Canonical"
    #     offer     = "ubuntu-24_04-lts"
    #     sku       = "server"
    #     version   = "latest"
    #   }
    #   features = {
    #     docker = true
    #   }
    # }

  }

}
