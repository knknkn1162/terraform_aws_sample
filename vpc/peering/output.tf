output "main_private_ip" {
  value = module.main_ec2.private_ip
}

output "peer_private_ip" {
  value = module.peer_ec2.private_ip
}