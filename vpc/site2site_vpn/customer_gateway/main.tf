variable "public_ip" {
  type = string
}

resource "aws_customer_gateway" "main" {
  bgp_asn    = 65000
  ip_address = var.public_ip
  type       = "ipsec.1"
}