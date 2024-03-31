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

module "sg4s3" {
  source = "./sg"
  vpc_id = module.vpc.id
  ingress_port = 443
  cidrs = [module.vpc.cidr]
}


resource "aws_vpc_endpoint" "s3_endpoint" {
    vpc_id          = module.vpc.id
    service_name    = local.service_name
    vpc_endpoint_type = "Interface"
    security_group_ids = [ module.sg4s3.id ]
    subnet_ids = [ module.subnet4vm.id ]
    private_dns_enabled = true
    # You must maintain this gateway endpoint while you have the Enable private DNS only for inbound endpoints option selected.
    # default -> true
    dns_options {
      private_dns_only_for_inbound_resolver_endpoint = false
    }
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

/*
resource "aws_vpc_endpoint_security_group_association" "example" {
  vpc_endpoint_id   = aws_vpc_endpoint.s3_endpoint.id
  security_group_id = module.sg4s3.id
}

resource "aws_vpc_endpoint_subnet_association" "example" {
  vpc_endpoint_id = aws_vpc_endpoint.s3_endpoint.id
  subnet_id       = module.subnet4vm.id
}
*/