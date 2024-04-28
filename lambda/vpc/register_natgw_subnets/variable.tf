variable "vpc_id" {
}

variable "natgw_subnet_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}