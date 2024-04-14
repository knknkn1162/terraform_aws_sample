variable "password" {
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

variable "edition" {
  type = string
  validation {
    condition = contains(["ee", "ex", "web", "se"], var.edition)
    error_message = "must be ee or ex or web or se"
  }
}