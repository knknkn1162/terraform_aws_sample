resource "aws_ecs_service" "mongo" {
  name            = "ecs-service-${uuid()}"
  cluster         = aws_ecs_cluster.example.id
  task_definition = aws_ecs_task_definition.example.arn
  # Number of instances of the task definition to place and keep running.
  desired_count   = 2
  #iam_role        = aws_iam_role.foo.arn

  load_balancer {
    target_group_arn = var.tg_arn
    container_name   = "container-${uuid()}"
    container_port   = 80
  }
  network_configuration {
    subnets = var.subnet_ids
    security_groups = [var.sg_id]
    # false by default
    # assign_public_ip = false
  }
}