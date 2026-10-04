locals {
  private_dns_zones = {
    blob = {
      name = "privatelink.blob.core.windows.net"
    }
    file = {
      name = "privatelink.file.core.windows.net"
    }
  }
}
