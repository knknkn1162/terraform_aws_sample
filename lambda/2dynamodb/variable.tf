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

variable "allow_gen_url" {
  type = bool
  default = false
}

variable "log_group_name" {
  type = string
}

variable "table_name" {
  type = string
}