# envs/prod/networks.auto.tfvars
vnet_name          = "prod-vnet"
vnet_address_space = ["10.0.0.0/16"]


nsgs = {
  prod = { name = "nsg-prod" }
}

subnet_nsg_associations = {
  prod = "prod"
}

subnets = {
  prod = {
    name             = "prod-subnet"
    address_prefixes = ["10.0.1.0/24"]
  }
}
nsg_rules = {
  prod = [
    {
      name                       = "Allow-SSH-From-Bastion"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "Deny-SSH-All"
      priority                   = 201
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]

}