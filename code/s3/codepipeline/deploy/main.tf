variable "force_destroy" {
  type = bool
}

locals {
  force_destroy = var.force_destroy
}

resource "aws_s3_bucket" "example" {
  bucket = "deploy-${uuid()}"
  force_destroy = local.force_destroy
}

output "arn" {
  value = aws_s3_bucket.example.arn
}

output "name" {
  value = aws_s3_bucket.example.bucket
}