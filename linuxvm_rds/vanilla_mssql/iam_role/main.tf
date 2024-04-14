variable "policy" {}
variable "identifier" {}

locals {
  strid = uuid()
}

resource "aws_iam_role" "default" {
  name = "iam-role-${local.strid}"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = [var.identifier]
    }
  }
}

resource "aws_iam_policy" "default" {
  name = "iam-policy-${local.strid}"
  policy = var.policy
}


resource "aws_iam_role_policy_attachment" "default" {
  role = aws_iam_role.default.name
  policy_arn = aws_iam_policy.default.arn
}

output "arn" {
  value = aws_iam_role.default.arn
}

output "name" {
  value = aws_iam_role.default.name
}