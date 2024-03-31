module "s3" {
  source = "./s3"
  s3_name = var.s3_name
}

locals {
  service_name = "com.amazonaws.${module.region.name}.s3"
}

module "region" {
  source = "./info/region"
}

/*
data "aws_iam_policy" "AmazonS3FullAccess" {
  arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
*/

resource "aws_vpc_endpoint" "s3_endpoint" {
    vpc_id          = module.vpc.id
    service_name    = local.service_name
    vpc_endpoint_type = "Gateway"
    #policy = data.aws_iam_policy.AmazonS3FullAccess.policy
    policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "s3:*",
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::*",
      "Principal": "*",
			"Condition": {
				"IpAddress": {
					"aws:VpcSourceIp": "${module.vm.private_ip}"
				}
			}
    }
  ]
}
POLICY
}
resource "aws_vpc_endpoint_route_table_association" "private_s3" {
    vpc_endpoint_id = aws_vpc_endpoint.s3_endpoint.id
    route_table_id  = module.rt4vm.id
}
