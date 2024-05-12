variable "vpc_id" {
  type = string
}

variable "rt_ids" {
  type = list(string)
}


module "user_info" {
  source = "../../userinfo"
}

locals {
  s3_service_name = "com.amazonaws.${module.user_info.region}.s3"
}


resource "aws_vpc_endpoint" "s3" {
  vpc_id       = var.vpc_id
  vpc_endpoint_type = "Gateway"
  service_name = local.s3_service_name
  route_table_ids = var.rt_ids
}

/*
resource "aws_vpc_endpoint_route_table_association" "private_s3" {
    vpc_endpoint_id = aws_vpc_endpoint.s3.id
    route_table_id  = var.rt_id
}
*/