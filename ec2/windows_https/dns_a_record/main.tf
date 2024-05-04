variable "root_domain" {
  type = string
}

variable "prefix" {
  type = string
}

variable "ip" {
  type = string
}

data "aws_route53_zone" "selected" {
  name         = var.root_domain
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "${var.prefix}.${var.root_domain}"
  type    = "A"
  ttl     = 60
  records = [var.ip]
}