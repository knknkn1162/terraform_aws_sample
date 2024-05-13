resource "aws_s3_bucket" "example" {
}

output "name" {
  value = aws_s3_bucket.example.bucket
}

output "arn" {
  value = aws_s3_bucket.example.arn
}