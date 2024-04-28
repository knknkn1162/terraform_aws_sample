variable "vpc_cidr" {
}
variable "bastion_spec" {
  type = string
}

variable "lambda_cidr" {
  type = string
}

variable "public_cidr" {
  type = string
}

variable "runtime" {
  type = string
}

variable "handler" {
  type = string
}

variable "source_dir" {
  type = string
}

variable "test_json_paths" {
  type = list(string)
  default = []
}