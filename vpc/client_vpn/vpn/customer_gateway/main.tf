variable "public_ip" {
  type = string
}

resource "aws_customer_gateway" "example" {
  bgp_asn    = 65000
  ip_address = var.public_ip
  # The only type AWS supports at this time is "ipsec.1".
  type       = "ipsec.1"
}

output "id" {
  value = aws_customer_gateway.example.id
}
output "type" {
  value = aws_customer_gateway.example.type
}