output "vnet_names" {
  value = {
    for key, v in module.vnet :
    key => v.vnet_name
  }
}

output "vnet_ids" {
  value = {
    for key, v in module.vnet :
    key => v.vnet_id
  }
}