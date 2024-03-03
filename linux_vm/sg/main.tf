variable "vpc_id" {}
variable "ingress_port" {
  type = number
}
variable "cidrs" {
  type = list(string)
}

# https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateSecurityGroup.html
# Constraints: Up to 255 characters in length. Cannot start with sg-.
resource "aws_security_group" "default" {
  name = "security-group-${uuid()}"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "ingress_example" {
  type = "ingress"
  from_port = var.ingress_port
  to_port = var.ingress_port
  protocol = "tcp"
  cidr_blocks = var.cidrs
  security_group_id = aws_security_group.default.id
}

resource "aws_security_group_rule" "egress_example" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.default.id
}


output "id" {
  value = aws_security_group.default.id
}