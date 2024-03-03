variable "cidrs" {
}

variable "vpc_id" {
}

resource "aws_subnet" "example" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidrs
}

output "id" {
  value = aws_subnet.example.id
}