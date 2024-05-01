variable "cidr" {}

variable "enable_dns_support" {
  type = bool
  default = true
}

variable "enable_dns_hostnames" {
  type = bool
  default = false
}

resource "aws_vpc" "main" {
  cidr_block = var.cidr
  enable_dns_support = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
}

output "id" {
  value = aws_vpc.main.id
}