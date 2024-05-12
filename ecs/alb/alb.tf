variable "subnet_ids" {
  type = list(string)
}

variable "sg_id" {
  type = string
}

variable "vpc_id" {
  type = string
}

resource "aws_lb" "example" {
  name = "lb-${uuid()}"
  load_balancer_type = "application"
  security_groups    = [var.sg_id]
  # must be public subnet
  subnets            = var.subnet_ids

  enable_deletion_protection = false
  # defaults to false
  # internal = false
}
/*
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
*/

resource "aws_lb_target_group" "example" {
  name     = "lb-target-group-${uuid()}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "instance"
}


# backend
resource "aws_lb_target_group_attachment" "test" {

  target_group_arn = aws_lb_target_group.example.arn
  # the container ID for an ECS container
  target_id        = var.ecs_id
  port             = 80
}