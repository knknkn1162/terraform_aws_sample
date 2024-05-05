variable "rt_id" {
  type = string
}

variable "nic_id" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

resource "aws_route" "cgw" {
  route_table_id = var.rt_id
  network_interface_id = var.nic_id
  destination_cidr_block = var.vpc_cidr
}