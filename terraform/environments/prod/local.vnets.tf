locals {
  vnets = {
    vnet-prod = {
      name          = "vnet-prod"
      address_space = ["10.10.0.0/16"]
     }
   }   
}