resource "aws_ecs_cluster" "example" {
  name = "ecs-${uuid()}"
}

data "aws_iam_role" "ecsTaskExecutionRole" {
  name = "ecsTaskExecutionRole"
}

resource "aws_ecs_task_definition" "example" {
  family                   = "td-${uuid()}"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  execution_role_arn = data.aws_iam_role.ecsTaskExecutionRole.arn
  container_definitions    = <<TASK_DEFINITION
[
  {
    "portMappings": [
      {
        "containerPort": 80, 
        "hostPort": 80, 
        "protocol": "tcp"
      }
    ], 
    "name": "container-${uuid()}",
    "image": "${var.ecr_image}",
    "cpu": 1024,
    "memory": 2048,
    "essential": true
  }
]
TASK_DEFINITION

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}