variable subnet_ids {
  type = list(string)
}
variable "vpc_id" {}
variable "backend_vm_ids" {
  type = list(string)
}

variable "domain" {
  type = string
}

variable "prefix" {
  type = string
}

data "aws_acm_certificate" "example" {
  domain    = "*.${var.domain}"
}


locals {
  backend_vm_id_map = { for idx, val in var.backend_vm_ids : idx => val }
  strid = substr(uuid(), 0, 15)
}

module "sg" {
  source = "../sg"
  vpc_id = var.vpc_id
  ingress_ports = [80, 443]
  cidrs = ["0.0.0.0/0"]
}

resource "aws_lb" "example" {
  name = "lb-${local.strid}"
  load_balancer_type = "application"
  security_groups    = [module.sg.id]
  # must be public subnet
  subnets            = var.subnet_ids

  enable_deletion_protection = false
  # defaults to false
  # internal = false
}

# redirect
resource "aws_lb_listener" "redirect_http2https" {
    load_balancer_arn = aws_lb.example.arn
    port = "80"
    protocol = "HTTP"

    default_action {
      type = "redirect"
      redirect {
        port = "443"
        protocol = "HTTPS"
        status_code = "HTTP_301"
      }
    }
}

# forward
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.example.arn
  port              = "443"
  protocol          = "HTTPS"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn = data.aws_acm_certificate.example.arn
}

resource "aws_lb_target_group" "test" {
  name     = "lb-target-group-${local.strid}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "instance"
}

# backend
resource "aws_lb_target_group_attachment" "test" {
  for_each = local.backend_vm_id_map
  target_group_arn = aws_lb_target_group.test.arn
  target_id        = each.value
  port             = 80
}

# register zone
data "aws_route53_zone" "example" {
  name         = var.domain
}

resource "aws_route53_record" "alb" {
  zone_id = data.aws_route53_zone.example.zone_id
  name    = "${var.prefix}.${var.domain}"
  type    = "A"
  alias {
    name                   = aws_lb.example.dns_name
    zone_id                = aws_lb.example.zone_id
    evaluate_target_health = false
  }
}


resource "aws_lb_listener_certificate" "example" {
  listener_arn    = aws_lb_listener.https.arn
  certificate_arn = data.aws_acm_certificate.example.arn
}


output "acm_arn" {
  value = data.aws_acm_certificate.example.arn
}

output "acm_dns" {
  value = aws_route53_record.alb.fqdn
}

output "alb_dns" {
  value = aws_lb.example.dns_name
}

output "zone_id" {
  value = aws_lb.example.zone_id
}