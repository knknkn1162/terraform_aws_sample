output "main_private_ip" {
  value = module.vyos.private_ip
}

output "main_public_ip" {
  value = module.vyos.public_ip
}

output "ssh_privkey" {
  value = module.vyos.ssh_privkey
  sensitive = true
}

output "user" {
  value = "vyos@${module.vyos.public_ip}"
}