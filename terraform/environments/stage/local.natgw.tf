locals {
  nat_gateways = {
    db = {
      name           = "natgw-db-stage"
      public_ip_name = "pip-natgw-db-stage"
      subnet_key     = "db"
    }
  }
}