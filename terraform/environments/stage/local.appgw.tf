
locals {
  appgateways = {
    main = {
      name        = "appgw-stage"
      subnet_key  = "appgateways" # Must match a key in your local.subnets map
    }
  }
}