locals {
   subnets = {

    db = {
      name             = "snet-db-stage"
      vnet             = "stage"
      address_prefixes = ["10.0.1.0/24"]
      private          = true
      nsg              = "db"
    }

    app = {
      name             = "snet-app-stage"
      vnet             = "stage"
      address_prefixes = ["10.0.2.0/24"]
      private          = false
      nsg              = "app"
    }

    web = {
      name             = "snet-web-stage"
      vnet             = "stage"
      address_prefixes = ["10.0.3.0/24"]
      private          = false
      nsg              = "web"
    }

    bastion = {
      name             = "AzureBastionSubnet"
      vnet             = "stage"
      address_prefixes = ["10.0.10.0/26"]
      private          = false
      nsg              = null
    }

    appgateway = {
      name             = "ApplicationGatewaySubnet"
      vnet             = "stage"
      address_prefixes = ["10.0.20.0/26"]
      private          = false
      nsg              = null
    }

    firewall = {
      name             = "AzureFirewallSubnet"
      vnet             = "firewall"
      address_prefixes = ["20.0.1.0/24"]
      private          = false
      nsg              = null
    }

    firewall_mgmt = {
      name             = "AzureFirewallManagementSubnet"
      vnet             = "firewall"
      address_prefixes = ["20.0.2.0/24"]
      private          = false
      nsg              = null
    }

  }

}