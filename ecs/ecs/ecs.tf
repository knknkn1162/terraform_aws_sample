resource "aws_ecs_cluster" "example" {
  name = "ecs-${uuid()}"
}