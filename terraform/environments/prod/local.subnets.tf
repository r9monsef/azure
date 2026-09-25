locals {
  subnets = {
    appgw = {
      name             = "AppGw-subnet-prd"
      vnet             = "vnet-prod"
      address_prefixes = ["10.10.0.0/24"]
      private          = true
      nsg              = null
    }

    biz = {
      name             = "biz-subnet-prd"
      vnet             = "vnet-prod"
      address_prefixes = ["10.10.5.0/24"]
      private          = false
      nsg              = "biz"
    }

    web = {
      name             = "web-subnet-prd"
      vnet             = "vnet-prod"
      address_prefixes = ["10.10.3.0/24"]
      private          = false
      nsg              = "web"
    }

    firewall = {
      name             = "AzureFirewallSubnet"
      vnet             = "vnet-prod"
      address_prefixes = ["10.10.1.0/26"]
      private          = false
      nsg              = null
    }

    firewall_mgmt = {
      name             = "AzureFirewallManagementSubnet"
      vnet             = "vnet-prod"
      address_prefixes = ["10.10.1.64/26"]
      private          = false
      nsg              = null
    }

    mssql = {
      name             = "mssql-subnet-prd"
      vnet             = "vnet-prod"
      address_prefixes = ["10.10.6.0/24"]
      private          = true
      nsg              = "mssql"
    }

    management = {
      name             = "management-subnet-prd"
      vnet             = "vnet-prod"
      address_prefixes = ["10.10.7.0/24"]
      private          = false
      nsg              = null
    }
  }
}