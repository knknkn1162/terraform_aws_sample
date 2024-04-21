/*
output "ssh_command" {
  value = "ssh -i key.pem ec2-user@${aws_instance.vm.private_ip}"
}
*/

output "vm_user" {
  # see https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/connect-to-linux-instance.html
  value = "ec2-user"
}

output "ssh_privkey" {
  value = tls_private_key.pk.private_key_pem
}

output "natgw_public_ip" {
  value = module.natgw.public_ip
}

output "id" {
  value = aws_instance.vm.id
}