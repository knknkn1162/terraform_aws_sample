variable "vpc_id" {
  type = string
}

resource "aws_security_group" "example" {
  vpc_id      = var.vpc_id
}

module "ingress" {
  source = "../core/ingress"
  security_group_id = aws_security_group.example.id
  is_any_cidr = true
  ports = [22]
}


module "egress" {
  source = "../core/egress/all"
  security_group_id = aws_security_group.example.id
}

output "id" {
  value = aws_security_group.example.id
}