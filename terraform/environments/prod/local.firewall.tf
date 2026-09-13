locals {

  subnet_cidrs = {
    appgw      = "10.10.0.0/24"
    firewall   = "10.10.1.0/26"
    web        = "10.10.3.0/24"
    biz        = "10.10.5.0/24"
    db         = "10.10.6.0/24"
    management = "10.10.7.0/24"
  }

  app_ports = {
    # App Gateway -> Web
    appgw_to_web = [
      "8080", # frontend / frontend-proxy
      "8089"  # load-generator
    ]

    # Web -> Biz
    web_to_biz = [
      "9555", "7070", "5050", "7001", "3550", 
      "8090", "9001", "50050", "8081", "8013", 
      "4317", "4318"
    ]

    web_to_biz_optional = [
      "4000", # flagd-ui
      "8000"  # telemetry-docs
    ]

    # Biz -> DB
    biz_to_db = [
      "5432", # postgres
      "6379"  # valkey
    ]

    management = ["22", "3389"]

    shared_udp_tcp = {
      dns = ["53"]
      ntp = ["123"]
    }
  }

  network_rule_collections = [
    {
      name     = "net-allow-management"
      priority = 100
      action   = "Allow"
      rules = [
        {
          name                  = "mgmt-to-web-ssh"
          protocols             = ["TCP"]
          source_addresses      = [local.subnet_cidrs.management]
          destination_addresses = [local.subnet_cidrs.web]
          destination_ports     = ["22"]
        },
        {
          name                  = "mgmt-to-web-rdp"
          protocols             = ["TCP"]
          source_addresses      = [local.subnet_cidrs.management]
          destination_addresses = [local.subnet_cidrs.web]
          destination_ports     = ["3389"]
        },
        {
          name                  = "mgmt-to-biz-ssh"
          protocols             = ["TCP"]
          source_addresses      = [local.subnet_cidrs.management]
          destination_addresses = [local.subnet_cidrs.biz]
          destination_ports     = ["22"]
        },
        {
          name                  = "mgmt-to-biz-rdp"
          protocols             = ["TCP"]
          source_addresses      = [local.subnet_cidrs.management]
          destination_addresses = [local.subnet_cidrs.biz]
          destination_ports     = ["3389"]
        },
        {
          name                  = "mgmt-to-db-ssh"
          protocols             = ["TCP"]
          source_addresses      = [local.subnet_cidrs.management]
          destination_addresses = [local.subnet_cidrs.db]
          destination_ports     = ["22"]
        },
        {
          name                  = "mgmt-to-db-rdp"
          protocols             = ["TCP"]
          source_addresses      = [local.subnet_cidrs.management]
          destination_addresses = [local.subnet_cidrs.db]
          destination_ports     = ["3389"]
        }
      ]
    },
    {
      name     = "net-allow-app-flow"
      priority = 110
      action   = "Allow"
      rules = [
        {
          name                  = "appgw-to-web"
          protocols             = ["TCP"]
          source_addresses      = [local.subnet_cidrs.appgw]
          destination_addresses = [local.subnet_cidrs.web]
          destination_ports     = local.app_ports.appgw_to_web
        },
        {
          name                  = "web-to-biz"
          protocols             = ["TCP"]
          source_addresses      = [local.subnet_cidrs.web]
          destination_addresses = [local.subnet_cidrs.biz]
          destination_ports     = concat(local.app_ports.web_to_biz, local.app_ports.web_to_biz_optional)
        },
        {
          name                  = "biz-to-db"
          protocols             = ["TCP"]
          source_addresses      = [local.subnet_cidrs.biz]
          destination_addresses = [local.subnet_cidrs.db]
          destination_ports     = local.app_ports.biz_to_db
        }
      ]
    },
    {
      name     = "net-allow-shared-services"
      priority = 120
      action   = "Allow"
      rules = [
        {
          name                  = "all-to-dns"
          protocols             = ["TCP", "UDP"]
          source_addresses      = [
            local.subnet_cidrs.web, local.subnet_cidrs.biz, 
            local.subnet_cidrs.db, local.subnet_cidrs.management
          ]
          destination_addresses = ["*"]
          destination_ports     = local.app_ports.shared_udp_tcp.dns
        },
        {
          name                  = "all-to-ntp"
          protocols             = ["UDP"]
          source_addresses      = [
            local.subnet_cidrs.web, local.subnet_cidrs.biz, 
            local.subnet_cidrs.db, local.subnet_cidrs.management
          ]
          destination_addresses = ["*"]
          destination_ports     = local.app_ports.shared_udp_tcp.ntp
        }
      ]
    }
  ]

  application_rule_collections = [
    {
      name     = "app-allow-outbound"
      priority = 200
      action   = "Allow"
      rules = [
        {
          name = "web-biz-outbound-web"
          source_addresses = [local.subnet_cidrs.web, local.subnet_cidrs.biz]
          protocols = [
            { type = "Http", port = 80 },
            { type = "Https", port = 443 }
          ]
          target_fqdns = [
            "*.microsoft.com", "*.windowsupdate.com", "*.azure.com", 
            "*.ubuntu.com", "archive.ubuntu.com", "security.ubuntu.com",
            "packages.microsoft.com", "download.docker.com", "registry-1.docker.io",
            "auth.docker.io", "production.cloudflare.docker.com", "ghcr.io"
          ]
        },
        {
          name = "management-outbound-web"
          source_addresses = [local.subnet_cidrs.management]
          protocols = [
            { type = "Http", port = 80 },
            { type = "Https", port = 443 }
          ]
          target_fqdns = ["*.microsoft.com", "*.azure.com", "*.windowsupdate.com", "packages.microsoft.com"]
        }
      ]
    }
  ]

  nat_rule_collections = []
}
