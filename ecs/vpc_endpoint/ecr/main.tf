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
  ecr_dkr_service_name = "com.amazonaws.${module.user_info.region}.ecr.dkr"
  ecr_api_service_name = "com.amazonaws.${module.user_info.region}.ecr.api"
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_endpoint_type = "Interface"
  service_name = local.ecr_dkr_service_name
  subnet_ids = var.subnet_ids
  vpc_id = var.vpc_id
  security_group_ids = [var.sg_id]
}

resource "aws_vpc_endpoint" "ecr_api" {
  vpc_endpoint_type = "Interface"
  service_name = local.ecr_api_service_name
  subnet_ids = var.subnet_ids
  vpc_id = var.vpc_id
  security_group_ids = [var.sg_id]
}