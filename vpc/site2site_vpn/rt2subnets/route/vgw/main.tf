variable "rt_id" {
  type = string
}

variable "vgw_id" {
  
}

resource "aws_vpn_gateway_route_propagation" "example" {
  vpn_gateway_id = var.vgw_id
  route_table_id = var.rt_id
}