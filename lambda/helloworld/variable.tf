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