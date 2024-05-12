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
  # . To do this, ensure that the Enable Private DNS Name option is selected in the Amazon VPC console when you create the VPC endpoint.
  # https://stackoverflow.com/a/73903596
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ecr_api" {
  vpc_endpoint_type = "Interface"
  service_name = local.ecr_api_service_name
  subnet_ids = var.subnet_ids
  vpc_id = var.vpc_id
  security_group_ids = [var.sg_id]
  # When this endpoint is created, you have the option to enable a private DNS hostname. Enable this setting by selecting Enable Private DNS Name in the VPC console when you create the VPC endpoint.
  # https://stackoverflow.com/a/73903596
  private_dns_enabled = true
}