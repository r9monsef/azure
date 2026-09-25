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


output "mssql_server_id" {
  value = module.mssql.server_id
}

output "mssql_server_name" {
  value = module.mssql.server_name
}

output "mssql_server_fqdn" {
  value = module.mssql.server_fqdn
}

output "mssql_database_id" {
  value = module.mssql.database_id
}

output "mssql_database_name" {
  value = module.mssql.database_name
}

output "mssql_subnet_key" {
  value = module.mssql.subnet_key
}