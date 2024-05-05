variable "security_group_id" {
  type = string
}

variable "is_any_cidr" {
  type = bool
  default = true
}

variable "cidr_ipv4" {
  type = string
  default = ""
}

variable "ports" {
  type = list(number)
}

locals {
  cidr_ipv4 = var.is_any_cidr ? "0.0.0.0/0" : var.cidr_ipv4
  port_map = { for idx, val in var.ports : idx => val }
}

resource "aws_vpc_security_group_egress_rule" "example" {
  for_each = local.port_map
  security_group_id = var.security_group_id
  cidr_ipv4 = local.cidr_ipv4
  from_port         = each.value
  to_port           = each.value
  // tcp, udp, icmp, icmpv6
  ip_protocol       = "tcp"
}