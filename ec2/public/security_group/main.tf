variable "vpc_id" {
  type = string
}

/*
variable "target_cidr" {
  type = string
}
*/

resource "aws_security_group" "example" {
  vpc_id      = var.vpc_id
}

module "ingress" {
  source = "./ingress/"
  security_group_id = aws_security_group.example.id
  is_any_cidr = true
  ports = [80,443,22]
}

/*
module "ingress_icmp" {
  source = "./ingress/icmp"
  security_group_id = aws_security_group.example.id
  target_cidr = var.target_cidr
}
*/

module "egress" {
  source = "./egress/all"
  security_group_id = aws_security_group.example.id
}


output "id" {
  value = aws_security_group.example.id
}