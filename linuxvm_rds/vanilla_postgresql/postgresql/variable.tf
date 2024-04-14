variable "password" {
  type = string
}

variable "db_name" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "db_version" {
  type = string
}

variable "spec" {
  type = string
}