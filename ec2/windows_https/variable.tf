variable "vpc_cidr" {
}
variable "public_cidr" {
  type = string
}

variable "ec2_spec" {
  type = string
}

variable "root_domain" {
  type = string
}

variable "prefix_domain" {
  type = string
}

variable "pfx_password" {
  type = string
}

locals {
  domain = "${var.prefix_domain}.${var.root_domain}"
}

variable "enable_ec2_ssm" {
  type = bool
  default = false
}