locals {
  address_spaces = {
    appgw      = "10.10.0.0/24"
    firewall   = "10.10.1.0/24"
    web        = "10.10.3.0/24"
    biz        = "10.10.5.0/24"
    mssql      = "10.10.6.0/24"
    management = "10.10.7.0/24"
    storage    = "10.10.10.0/24"
  }

  biz_ilb_ip = "10.10.5.10"

  ports = {
    web_inbound = [
      "8080",
      "8089"
    ]

    biz_inbound = [
      "7070",
      "3550",
      "9001",
      "50050",
      "50051",
      "5050",
      "9555",
      "8013",
      "4317",
      "4318",
      "7001",
      "6060",
      "8090",
      "8081"
    ]

    mgmt = [
      "22",
      "3389"
    ]

    storage_inbound = [
      "443", # HTTPS for Blob Storage & Management API
      "445"  # SMB / CIFS for Azure Files
    ]
  }

  nsgs = {

    # -------------------------------------------------
    # WEB TIER NSG
    # -------------------------------------------------
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
          name                       = "allow-web-to-biz"
          priority                   = 100
          direction                  = "Outbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_ranges    = local.ports.biz_inbound
          source_address_prefix      = local.address_spaces.web
          destination_address_prefix = local.address_spaces.biz
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
          destination_address_prefix = "0.0.0.0/0"
        }
      ]
    }

    # -------------------------------------------------
    # BIZ / APP TIER NSG
    # -------------------------------------------------
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
          name                       = "allow-biz-to-mssql"
          priority                   = 100
          direction                  = "Outbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = local.address_spaces.biz
          destination_address_prefix = local.address_spaces.mssql
        },
        {
          name                       = "allow-biz-to-storage"
          priority                   = 110
          direction                  = "Outbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_ranges    = local.ports.storage_inbound
          source_address_prefix      = local.address_spaces.biz
          destination_address_prefix = local.address_spaces.storage
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

    # -------------------------------------------------
    # MSSQL PRIVATE ENDPOINT NSG
    # -------------------------------------------------
    mssql = {
      inbound = [
        {
          name                       = "allow-biz-to-mssql"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = local.address_spaces.biz
          destination_address_prefix = local.address_spaces.mssql
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

    # -------------------------------------------------
    # STORAGE PRIVATE ENDPOINT NSG
    #
    # ONLY BIZ/APP SUBNET CAN ACCESS BLOB (443) AND SMB (445).
    # ALL OTHER INBOUND AND OUTBOUND TRAFFIC IS DENIED.
    # -------------------------------------------------
    storage = {
      inbound = [
        {
          name                       = "allow-biz-to-storage"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_ranges    = local.ports.storage_inbound
          source_address_prefix      = local.address_spaces.biz
          destination_address_prefix = local.address_spaces.storage
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
