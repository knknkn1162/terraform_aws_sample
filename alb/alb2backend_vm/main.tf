variable subnet_ids {
  type = list(string)
}
variable "vpc_id" {}
variable "backend_vm_ids" {
  type = list(string)
}

locals {
  backend_vm_id_map = { for idx, val in var.backend_vm_ids : idx => val }
  strid = substr(uuid(), 0, 15)
}

module "sg" {
  source = "../sg"
  vpc_id = var.vpc_id
  ingress_port = 80
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
/*
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
*/

# forward
resource "aws_lb_listener" "example" {
  load_balancer_arn = aws_lb.example.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "dummy"
      status_code  = "200"
    }
  }
}


# listener rule
resource "aws_lb_listener_rule" "example" {
  listener_arn = aws_lb_listener.example.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }
  condition {
    path_pattern {
      values = ["/*"]
    }
  }
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


output "dns" {
  value = aws_lb.example.dns_name
}