variable "ecr_repo_url" {
  type = string
}

variable "tg_arn" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "sg_id" {
  type = string
}

variable "cnt" {
  type = string
}

variable "container_port" {
  type = string
}

variable "host_port" {
  type = string
}