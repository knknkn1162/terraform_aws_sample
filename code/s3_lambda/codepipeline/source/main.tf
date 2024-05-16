resource "aws_s3_bucket" "example" {
}

output "arn" {
  value = aws_s3_bucket.example.arn
}

output "name" {
  value = aws_s3_bucket.example.bucket
}