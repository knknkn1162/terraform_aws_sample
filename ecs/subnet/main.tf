variable "vpc_id" {
}

variable "cidr" {
  type = string
}

resource "aws_subnet" "example" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr
}

resource "aws_route_table" "example" {
  vpc_id = var.vpc_id
}

resource "aws_route_table_association" "example" {
  subnet_id = aws_subnet.example.id
  route_table_id = aws_route_table.example.id
}

output "id" {
  value = aws_subnet.example.id
}

output "rt_id" {
  value = aws_route_table.example.id
}