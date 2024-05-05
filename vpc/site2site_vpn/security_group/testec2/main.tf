variable "vpc_id" {
  type = string
}

variable "icmp_target_cidr" {
  type = string
}

resource "aws_security_group" "example" {
  vpc_id      = var.vpc_id
}

module "ingress" {
  source = "../core/ingress/icmp"
  security_group_id = aws_security_group.example.id
  cidr_ipv4 = var.icmp_target_cidr
}


module "egress" {
  source = "../core/egress/all"
  security_group_id = aws_security_group.example.id
}

output "id" {
  value = aws_security_group.example.id
}