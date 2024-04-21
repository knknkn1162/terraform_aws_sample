variable "vm_spec" {
  type = string
}
variable "vm_cidr" {
  type = string
}

variable "vm_subnet_id" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "user_data" {
  type = string
  default = ""
}