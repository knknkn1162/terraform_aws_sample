variable "security_group_id" {
  type = string
}

variable "target_cidr" {
  type = string
  default = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "example" {
  security_group_id = var.security_group_id
  cidr_ipv4 = var.target_cidr
  # start port is -1 (all ICMP types), then the end port must be -1 (all ICMP codes).
  from_port         = -1
  to_port           = -1
  // tcp, udp, icmp, icmpv6
  ip_protocol       = "icmp"
}