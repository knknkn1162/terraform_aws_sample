locals {
  container_name = "container-${uuid()}"
  launch_type = "FARGATE"
}

resource "aws_cloudwatch_log_group" "example" {
}

resource "aws_ecs_task_definition" "example" {
  family                   = "td-${uuid()}"
  requires_compatibilities = [local.launch_type]
  network_mode             = "awsvpc"
  // MB
  cpu                      = 1024
  memory                   = 2048
  execution_role_arn = aws_iam_role.example.arn
  # see https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html
  # awslogs: https://docs.aws.amazon.com/ja_jp/AmazonECS/latest/developerguide/using_awslogs.html
  container_definitions    = <<TASKDEF
[
  {
    "portMappings": [
      {
        "containerPort": 80, 
        "hostPort": 80, 
        "protocol": "tcp"
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${aws_cloudwatch_log_group.example.name}",
        "awslogs-region": "ap-northeast-1",
        "awslogs-stream-prefix": "ecs"
      }
    },
    "name": "${local.container_name}",
    "image": "${var.ecr_repo_url}:latest",
    "essential": true
  }
]
TASKDEF

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}

resource "aws_ecs_service" "example" {
  name            = "ecs-service-${uuid()}"
  launch_type = local.launch_type
  cluster         = aws_ecs_cluster.example.id
  task_definition = aws_ecs_task_definition.example.arn
  # defaults to LATEST
  # platform_version = "LATEST"

  # Number of instances of the task definition to place and keep running.
  desired_count   = var.cnt

  # set instead of `aws_lb_target_group_attachment`
  load_balancer {
    target_group_arn = var.tg_arn
    container_name   = local.container_name
    container_port   = 80
  }

  network_configuration {
    subnets = var.subnet_ids
    security_groups = [var.sg_id]
    # false by default
    # assign_public_ip = false
  }
}