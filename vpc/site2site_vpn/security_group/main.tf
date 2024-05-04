variable "vpc_id" {
  type = string
}

variable "target_cidr" {
  type = string
}

resource "aws_security_group" "example" {
  vpc_id      = var.vpc_id
}

module "ingress" {
  source = "./ingress"
  security_group_id = aws_security_group.example.id
  cidr_ipv4 = var.target_cidr
  ports = [80,443,22]
}


module "egress" {
  source = "./egress/all"
  security_group_id = aws_security_group.example.id
}

output "id" {
  value = aws_security_group.example.id
}