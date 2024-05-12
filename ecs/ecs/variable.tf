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