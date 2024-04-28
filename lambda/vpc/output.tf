output "private_ip" {
  value = module.lambda.private_ip
}

output "egress_public_ip" {
  value = module.register_egress_subnets.public_ip
}

output "egress_private_ip" {
  value = module.register_egress_subnets.private_ip
}