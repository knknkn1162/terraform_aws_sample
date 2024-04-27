variable "domain" {
  type = string
}

# Route53
data "aws_route53_zone" "example" {
  name = var.domain
}

output "zone_id" {
  value = data.aws_route53_zone.example.zone_id
}

output "name" {
  value = data.aws_route53_zone.example.name
}