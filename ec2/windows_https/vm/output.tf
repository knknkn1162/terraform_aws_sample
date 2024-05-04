/*
output "ssh_command" {
  value = "ssh -i key.pem ec2-user@${aws_instance.vm.private_ip}"
}
*/

output "vm_user" {
  # see https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/connect-to-linux-instance.html
  value = "Administrator"
}

output "ssh_privkey" {
  value = tls_private_key.pk.private_key_pem
}

output "id" {
  value = aws_instance.vm.id
}