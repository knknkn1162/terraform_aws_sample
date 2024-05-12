variable "ecr_image" {
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