variable "cidr" {
}

variable "vpc_id" {
}

resource "aws_subnet" "example" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr
}

output "id" {
  value = aws_subnet.example.id
}

output "cidr" {
  value = var.cidr
}