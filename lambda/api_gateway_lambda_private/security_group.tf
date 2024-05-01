
resource "aws_security_group" "example" {
  vpc_id      = module.vpc.id
}

module "egress" {
  source = "./security_group/egress/all"
  security_group_id = aws_security_group.example.id
  is_any_cidr = true
}

module "ingress" {
  source = "./security_group/ingress"
  security_group_id = aws_security_group.example.id
  is_any_cidr = true
  ports = [443]
}