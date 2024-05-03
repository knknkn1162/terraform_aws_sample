variable "cidr" {}
variable "enable_private_dns" {
  type = bool
}
resource "aws_vpc" "main" {
  cidr_block = var.cidr
  # Enabling private DNS requires both enableDnsSupport and enableDnsHostnames VPC attributes set to true
  #enable_dns_support = true
  enable_dns_hostnames = var.enable_private_dns
}

output "id" {
  value = aws_vpc.main.id
}

output "cidr" {
  value = aws_vpc.main.cidr_block
}