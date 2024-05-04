variable "domain" {
  type = string
}

# https://docs.aws.amazon.com/acm/latest/userguide/acm-regions.html
# To use an ACM certificate with Amazon CloudFront, you must request or import the certificate in the US East (N. Virginia) region.
provider "aws" {
  alias  = "virginia"
  region = "us-east-1"
}

data "aws_acm_certificate" "virginia" {
  domain    = "*.${var.domain}"
  provider = aws.virginia
}

data "aws_route53_zone" "example" {
  name         = var.domain
}


output "arn" {
  value = data.aws_acm_certificate.virginia.arn
}

output "zone_id" {
  value = data.aws_route53_zone.example.zone_id
}