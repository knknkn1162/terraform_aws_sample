
data "aws_caller_identity" "current" {}

output "account_id" {
  value = "${data.aws_caller_identity.current.account_id}"
}

output "arn" {
  value = "${data.aws_caller_identity.current.arn}"
}

output "user" {
  value = "${data.aws_caller_identity.current.user_id}"
}

data "aws_region" "current" {}

output "region" {
  value = data.aws_region.current.name
}