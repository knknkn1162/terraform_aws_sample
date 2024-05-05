output "privkey" {
  value = module.ec2.privkey
  sensitive = true
}

output "ssh" {
  value = "ssh -i ${var.privkey_filepath} ec2-user@${module.ec2.public_ip}"
}