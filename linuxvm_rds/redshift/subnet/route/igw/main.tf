variable "vpc_id" {
  type = string
}

variable "route_table_id" {
  type = string
}

resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id
}

resource "aws_route" "route" {
  route_table_id            = var.route_table_id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}

output "id" {
  value = aws_internet_gateway.igw.id
}