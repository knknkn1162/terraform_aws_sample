variable "subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "sg_id" {
  type = string
}


module "user_info" {
  source = "../../userinfo"
}

locals {
  log_service_name = "com.amazonaws.${module.user_info.region}.logs"
}

resource "aws_vpc_endpoint" "cloudwatch" {
  vpc_endpoint_type = "Interface"
  service_name = local.log_service_name
  subnet_ids = var.subnet_ids
  vpc_id = var.vpc_id
  security_group_ids = [var.sg_id]
  # https://stackoverflow.com/a/73903596
  private_dns_enabled = true
}