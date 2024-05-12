variable "vpc_id" {
  type = string
}

variable "rt_ids" {
  type = list(string)
}

resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id
}

locals {
  rt_id_map = {for key, value in var.rt_ids: key => value}
}

resource "aws_route" "route" {
  for_each = local.rt_id_map
  route_table_id            = each.value
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}

output "id" {
  value = aws_internet_gateway.igw.id
}