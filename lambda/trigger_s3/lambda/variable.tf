variable "handler" {
  type = string
}

variable "runtime" {
  type = string
}

variable "source_dir" {
  type = string
}

variable "allow_policy_arns" {
  type = list(string)
}

variable "log_group_name" {
  type = string
}