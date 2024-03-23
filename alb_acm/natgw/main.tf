variable "subnet_id" {}

resource "aws_eip" "natgw" {
  domain   = "vpc"
}

resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.natgw.id
  subnet_id     = var.subnet_id
}

output "public_ip" {
  value = aws_eip.natgw.public_ip
}

output "id" {
  value = aws_nat_gateway.example.id
}