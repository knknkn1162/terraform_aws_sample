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

locals {
  cidr_ipv4 = var.is_any_cidr ? "0.0.0.0/0" : var.cidr_ipv4
}

resource "aws_vpc_security_group_egress_rule" "example" {
  security_group_id = var.security_group_id
  cidr_ipv4 = local.cidr_ipv4
  ip_protocol       = -1
}