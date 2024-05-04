variable "rt_id" {
  type = string
}

variable "dest_cidr" {
  type = string
}

variable "peering_id" {
  type = string
}

resource "aws_route" "route1" {
  route_table_id            = var.rt_id
  destination_cidr_block    = var.dest_cidr
  vpc_peering_connection_id = var.peering_id
}