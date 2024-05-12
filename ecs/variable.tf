variable "ecr_repo" {
  type = string
}

variable "original_repo" {
  type = string
}

variable "vpc_cidr" {
}
variable "public1_cidr" {
  type = string
}
variable "public2_cidr" {
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

locals {
  domain = "${var.prefix_domain}.${var.root_domain}"
}