output "private_ip" {
  value = aws_instance.example.private_ip
}

output "public_ip" {
  value = aws_instance.example.public_ip
}

output "id" {
  value = aws_instance.example.id
}