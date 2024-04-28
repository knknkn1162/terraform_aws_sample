variable "handler" {
  type = string
}

variable "runtime" {
  type = string
}

variable "source_dir" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "sg_ids" {
  type = list(string)
}

variable "allow_policy_arns" {
  type = list(string)
}