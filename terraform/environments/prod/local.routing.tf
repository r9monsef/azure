locals {
  firewall_private_ip = "10.10.1.4"

  route_tables = {
    appgw = {
      name                          = "rt-appgw-prd"
      disable_bgp_route_propagation = false
      routes = [
        {
          name                   = "default-to-firewall"
          address_prefix         = "0.0.0.0/0"
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = local.firewall_private_ip
        },
        {
          name                   = "to-web-via-firewall"
          address_prefix         = "10.10.3.0/24"
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = local.firewall_private_ip
        },
        {
          name                   = "to-biz-via-firewall"
          address_prefix         = "10.10.5.0/24"
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = local.firewall_private_ip
        },
        {
          name                   = "to-db-via-firewall"
          address_prefix         = "10.10.6.0/24"
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = local.firewall_private_ip
        },
        {
          name                   = "to-management-via-firewall"
          address_prefix         = "10.10.7.0/24"
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = local.firewall_private_ip
        }
      ]
    }

    web = {
      name                          = "rt-web-prd"
      disable_bgp_route_propagation = false
      routes = [
        {
          name                   = "default-to-firewall"
          address_prefix         = "0.0.0.0/0"
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = local.firewall_private_ip
        }
      ]
    }

    biz = {
      name                          = "rt-biz-prd"
      disable_bgp_route_propagation = false
      routes = [
        {
          name                   = "default-to-firewall"
          address_prefix         = "0.0.0.0/0"
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = local.firewall_private_ip
        }
      ]
    }

    db = {
      name                          = "rt-db-prd"
      disable_bgp_route_propagation = false
      routes = [
        {
          name                   = "default-to-firewall"
          address_prefix         = "0.0.0.0/0"
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = local.firewall_private_ip
        }
      ]
    }

    management = {
      name                          = "rt-management-prd"
      disable_bgp_route_propagation = false
      routes = [
        {
          name                   = "default-to-firewall"
          address_prefix         = "0.0.0.0/0"
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = local.firewall_private_ip
        }
      ]
    }
  }

  route_table_associations = {
    appgw = {
      subnet_key      = "appgw"
      route_table_key = "appgw"
    }

    web = {
      subnet_key      = "web"
      route_table_key = "web"
    }

    biz = {
      subnet_key      = "biz"
      route_table_key = "biz"
    }

    db = {
      subnet_key      = "db"
      route_table_key = "db"
    }

    management = {
      subnet_key      = "management"
      route_table_key = "management"
    }
  }
}