variable "bucket" {
  type = string
}

locals {
  # see https://docs.aws.amazon.com/ja_jp/elasticloadbalancing/latest/application/enable-access-logging.html
  elb_account_id = "582318560864"
}

resource "aws_s3_bucket" "example" {
  bucket = var.bucket
  force_destroy = true
}

resource "aws_s3_bucket_policy" "alg_log" {
    bucket = aws_s3_bucket.example.id
    policy = data.aws_iam_policy_document.alb_log.json
}

data "aws_iam_policy_document" "alb_log" {
    statement {
        effect = "Allow"
        actions = ["s3:PutObject"]
        resources = ["arn:aws:s3:::${aws_s3_bucket.example.bucket}/*"]
        principals {
            type = "AWS"
            identifiers = [local.elb_account_id]
        }
    }
}

output "arn" {
  value = aws_s3_bucket.example.arn
}

output "id" {
  value = aws_s3_bucket.example.id
}

output "name" {
  value = aws_s3_bucket.example.bucket_domain_name
}