variable "ecr_repo" {
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

variable "private1_cidr" {
  type = string
}
variable "private2_cidr" {
  type = string
}

variable "container_cnt" {
  type = number
}