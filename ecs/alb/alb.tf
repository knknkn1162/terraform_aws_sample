variable "subnet_ids" {
  type = list(string)
}

variable "sg_id" {
  type = string
}

variable "vpc_id" {
  type = string
}

resource "random_string" "string" {
  length           = 16
  special          = false
  lifecycle {
    ignore_changes = [
      length,
      special,
    ]
  }
}

locals {
  label = random_string.string.result
}

resource "aws_lb" "example" {
  name = "lb-${local.label}"
  load_balancer_type = "application"
  security_groups    = [var.sg_id]
  # must be public subnet
  subnets            = var.subnet_ids

  enable_deletion_protection = false
  # defaults to false
  # internal = false
}

# forward
resource "aws_lb_listener" "example" {
  load_balancer_arn = aws_lb.example.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.example.arn
  }
}


# listener rule
resource "aws_lb_listener_rule" "example" {
  listener_arn = aws_lb_listener.example.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.example.arn
  }
  condition {
    path_pattern {
      values = ["*"]
    }
  }
}


resource "aws_lb_target_group" "example" {
  name     = "lb-tg-${local.label}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"
}

/*
# no need because of load_balancer>target_group_arn
resource "aws_lb_target_group_attachment" "example" {

  target_group_arn = aws_lb_target_group.example.arn
  # the container ID for an ECS container
  target_id        = var.ecs_id
  port             = 80
}
*/