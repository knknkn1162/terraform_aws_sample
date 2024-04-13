output "ssh_privkey" {
  value = module.vm.ssh_privkey
  sensitive = true
}

output "vm_user" {
  value = module.vm.vm_user
}

output "psql_command" {
  value = module.aurora_postgresql.psql_command
}