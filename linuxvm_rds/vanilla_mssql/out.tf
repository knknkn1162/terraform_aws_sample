
output "sqlcmd_command" {
  value = module.vanilla_mssql.connection_command
}

output "user_data" {
  value = module.bastion.user_data
}