locals {
  vnets = {
    stage = {
      name          = "vnet-stage"
      address_space = ["10.0.0.0/16"]
    }

    firewall = {
      name          = "vnet-firewall"
      address_space = ["20.0.0.0/16"]
    }
  }
}