locals {
  address_spaces = {
    appgw      = "10.10.0.0/24"
    firewall   = "10.10.1.0/24"
    web        = "10.10.3.0/24"
    biz        = "10.10.5.0/24"
    db         = "10.10.6.0/24"
    management = "10.10.7.0/24"
  }

  # آی‌پی داخلی Load Balancer لایه بیزینس (اگر استفاده می‌کنی)
  biz_ilb_ip = "10.10.5.10"

  ports = {
    web_inbound = ["8080", "8089"]
    biz_inbound = [
      "7070", "3550", "9001", "50050", "50051", 
      "5050", "9555", "8013", "4317", "4318", 
      "7001", "6060", "8090", "8081"
    ]
    db_inbound = ["5432", "6379"]
    mgmt       = ["22", "3389"]
  }

  nsgs = {
    # --- WEB TIER NSG ---
    web = {
      inbound = [
        {
          name                       = "allow-appgw-to-web"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_ranges    = local.ports.web_inbound
          source_address_prefix      = local.address_spaces.appgw
          destination_address_prefix = local.address_spaces.web
        },
        {
          name                       = "allow-mgmt-to-web"
          priority                   = 110
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_ranges    = local.ports.mgmt
          source_address_prefix      = local.address_spaces.management
          destination_address_prefix = local.address_spaces.web
        },
        {
          name                       = "deny-all-inbound"
          priority                   = 900
          direction                  = "Inbound"
          access                     = "Deny"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
      outbound = [
        {
          name                       = "allow-web-to-biz-ilb"
          priority                   = 100
          direction                  = "Outbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_ranges    = local.ports.biz_inbound
          source_address_prefix      = local.address_spaces.web
          destination_address_prefix = local.address_spaces.biz # یا local.biz_ilb_ip
        },
        {
          name                       = "allow-outbound-to-firewall"
          priority                   = 200
          direction                  = "Outbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = local.address_spaces.web
          destination_address_prefix = "0.0.0.0/0" # اجازه خروج برای بررسی در Firewall
        }
      ]
    }

    # --- BIZ TIER NSG ---
    biz = {
      inbound = [
        {
          name                       = "allow-web-to-biz"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_ranges    = local.ports.biz_inbound
          source_address_prefix      = local.address_spaces.web
          destination_address_prefix = local.address_spaces.biz
        },
        {
          name                       = "allow-mgmt-to-biz"
          priority                   = 110
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_ranges    = local.ports.mgmt
          source_address_prefix      = local.address_spaces.management
          destination_address_prefix = local.address_spaces.biz
        },
        {
          name                       = "deny-all-inbound"
          priority                   = 900
          direction                  = "Inbound"
          access                     = "Deny"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
      outbound = [
        {
          name                       = "allow-biz-to-db"
          priority                   = 100
          direction                  = "Outbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_ranges    = local.ports.db_inbound
          source_address_prefix      = local.address_spaces.biz
          destination_address_prefix = local.address_spaces.db
        },
        {
          name                       = "allow-outbound-to-firewall"
          priority                   = 200
          direction                  = "Outbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = local.address_spaces.biz
          destination_address_prefix = "0.0.0.0/0"
        }
      ]
    }

    # --- DB TIER NSG ---
    db = {
      inbound = [
        {
          name                       = "allow-biz-to-db"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_ranges    = local.ports.db_inbound
          source_address_prefix      = local.address_spaces.biz
          destination_address_prefix = local.address_spaces.db
        },
        {
          name                       = "allow-mgmt-to-db"
          priority                   = 110
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_ranges    = local.ports.mgmt
          source_address_prefix      = local.address_spaces.management
          destination_address_prefix = local.address_spaces.db
        },
        {
          name                       = "deny-all-inbound"
          priority                   = 900
          direction                  = "Inbound"
          access                     = "Deny"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
      outbound = [
        {
          name                       = "deny-all-outbound"
          priority                   = 900
          direction                  = "Outbound"
          access                     = "Deny"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
    }
  }
}
