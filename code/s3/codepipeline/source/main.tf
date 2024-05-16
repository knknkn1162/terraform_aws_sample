variable "force_destroy" {
  type = bool
}

locals {
  force_destroy = var.force_destroy
}

resource "aws_s3_bucket" "example" {
  bucket = "source-${uuid()}"
  force_destroy = local.force_destroy
}

# The Amazon S3 bucket is not versioned
resource "aws_s3_bucket_versioning" "example" {
  bucket = aws_s3_bucket.example.id
  versioning_configuration {
    status = "Enabled"
  }
}

output "arn" {
  value = aws_s3_bucket.example.arn
}

output "name" {
  value = aws_s3_bucket.example.bucket
}

output "id" {
  value =aws_s3_bucket.example.id
}