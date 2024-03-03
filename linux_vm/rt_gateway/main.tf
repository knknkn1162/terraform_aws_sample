variable "vpc_id" {
}

variable "igw_id" {}

variable "subnet_ids" {
  type = set(string)
}

resource "aws_route_table" "example" {
  vpc_id = var.vpc_id
}

resource "aws_route" "r" {
  route_table_id            = aws_route_table.example.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = var.igw_id
}

resource "aws_route_table_association" "example" {
  for_each = var.subnet_ids
  subnet_id = each.key
  route_table_id = aws_route_table.example.id
}

output "rt_id" {
  value = aws_route_table.example.id
}