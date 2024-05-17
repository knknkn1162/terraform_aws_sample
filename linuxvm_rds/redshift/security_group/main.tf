variable "vpc_id" {
  type = string
}

locals {
  redshift_default_port = 5439
}
resource "aws_security_group" "example" {
  vpc_id      = var.vpc_id
}

module "ingress" {
  source = "./ingress"
  security_group_id = aws_security_group.example.id
  is_any_cidr = true
  ports = [local.redshift_default_port]
}


module "egress" {
  source = "./egress/all"
  security_group_id = aws_security_group.example.id
}

output "id" {
  value = aws_security_group.example.id
}