resource "aws_ecr_repository" "example" {
  name                 = var.repo
  image_scanning_configuration {
    scan_on_push = true
  }
  force_delete = true
}