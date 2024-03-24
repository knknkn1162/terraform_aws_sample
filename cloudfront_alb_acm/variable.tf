variable vpc_cidr {
  type = string
}
variable vm_spec {
  type = string
}

variable "vm1_cidr" {
  type = string
}

variable "natgw_cidr" {
  type = string
}
variable public1_cidr {
  type = string
}
variable public2_cidr {
  type = string
}
variable prefix {
  type = string
}
variable alb_domain {
  type = string
}
variable cloudfront_domain {
  type = string
}