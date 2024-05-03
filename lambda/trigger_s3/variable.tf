variable "runtime" {
  type = string
}

variable "handler" {
  type = string
}

variable "source_dir" {
  type = string
}

variable "allow_gen_url" {
  type = bool
  default = false
}

variable "log_group_name" {
  type = string
}

variable "s3_name" {
  type = string
}

variable "env" {
  type = string
}

locals {
  s3_force_destroy = lower(var.env) == "dev" ? true : false
}