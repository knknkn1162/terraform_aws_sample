variable "vpc_cidr" {
  type = string
}

variable "bastion_spec" {
  type = string
}

variable "public_cidr" {
  type = string
}

variable "db_cidrs" {
  type = list(string)
}

variable "db_name" {
  type = string
}

variable "db_password" {
  type = string
}