variable "vpc_id" {
  type = string
}

resource "aws_vpn_gateway" "vpn" {
}

resource "aws_vpn_gateway_attachment" "vpn_attachment" {
  vpc_id         = var.vpc_id
  vpn_gateway_id = aws_vpn_gateway.vpn.id
}