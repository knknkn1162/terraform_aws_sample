
resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "example" {
  public_key = tls_private_key.pk.public_key_openssh
}

output "privkey" {
  value = tls_private_key.pk.private_key_pem
}

output "pubkey" {
  value = aws_key_pair.example.key_name
}