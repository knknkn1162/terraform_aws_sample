variable "vpc1_cidr" {
}

variable "vpc2_cidr" {
}

variable "public1_cidr" {
  type = string
}

variable "private1_cidr" {
  type = string
}

variable "public2_cidr" {
  type = string
}

variable "private2_cidr" {
  type = string
}

variable "ec2spec4cgw" {
  type = string
}

variable "ec2spec4test" {
  type = string
}

locals {
  local_filepath = "${path.module}/vyos.conf"
  remote_filepath = "/tmp/vyos.conf"
}