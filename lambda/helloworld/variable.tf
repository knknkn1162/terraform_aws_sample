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

variable "allow_policy_arns" {
  type = list(string)
  default = []
}

variable "allow_gen_url" {
  type = bool
  default = false
}