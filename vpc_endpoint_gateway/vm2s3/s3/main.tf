variable "s3_name" {
  type = string
}

resource "aws_s3_bucket" "default" {
  bucket = var.s3_name
}

output "arn" {
  value = aws_s3_bucket.default.arn
}