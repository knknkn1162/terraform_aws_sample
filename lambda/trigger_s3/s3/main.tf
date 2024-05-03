variable "name" {
  type = string
}

variable "force_destroy" {
  type = bool
  default = false
}

resource "aws_s3_bucket" "example" {
  bucket = var.name
  # for test
  force_destroy = var.force_destroy
}

output "arn" {
  value = aws_s3_bucket.example.arn
}

output "name" {
  value = aws_s3_bucket.example.bucket
}