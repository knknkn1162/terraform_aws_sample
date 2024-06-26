variable "cidr" {}

resource "aws_vpc" "main" {
  cidr_block = var.cidr
}

output "id" {
  value = aws_vpc.main.id
}

output "cidr" {
  value = aws_vpc.main.cidr_block
}