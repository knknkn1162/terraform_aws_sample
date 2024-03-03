variable "cidrs" {}

resource "aws_vpc" "main" {
  cidr_block = var.cidrs
}

output "id" {
  value = aws_vpc.main.id
}