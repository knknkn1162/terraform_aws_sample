variable "cidr" {}

resource "aws_vpc" "main" {
  cidr_block = var.cidr
  # For vpc endpoint, Enabling private DNS requires both enableDnsSupport and enableDnsHostnames VPC attributes set to true
  enable_dns_support = true
  enable_dns_hostnames = true
}

output "id" {
  value = aws_vpc.main.id
}