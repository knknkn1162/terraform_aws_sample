
variable "vpc_cidr" {
}

variable "vm_spec" {
  type = string
}

variable public_cidr {
  type = string
}
variable pfx_password {
  type = string
}
variable dns_prefix {
  type = string
}
variable "root_domain" {
  type = string
}