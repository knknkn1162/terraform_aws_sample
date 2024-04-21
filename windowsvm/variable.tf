
variable "vpc_cidr" {
}

variable "vm_spec" {
  type = string
}
variable "vm_cidr" {
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