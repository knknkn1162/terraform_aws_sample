resource "aws_cloudwatch_log_group" "example" {
}


resource "aws_cloudwatch_log_stream" "example" {
  name           = "ecs"
  log_group_name = aws_cloudwatch_log_group.example.name
}