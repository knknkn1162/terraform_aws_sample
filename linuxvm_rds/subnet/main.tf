variable "cidr" {
}

variable "vpc_id" {
}

variable "az" {
  type = string
  default = "ap-northeast-1a"
}

resource "aws_subnet" "example" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr
  availability_zone = var.az
}

output "id" {
  value = aws_subnet.example.id
}