data "aws_region" "current" {}

output "name" {
  value = data.aws_region.current.name
}