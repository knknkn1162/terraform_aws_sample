
resource "aws_iam_user" "example" {
  name = "user-${uuid()}"
}

data "aws_iam_policy_document" "example" {
  statement {
    effect = "Allow"
    actions   = ["ses:SendRawEmail"]
    resources = ["*"]
  }
}

resource "aws_iam_user_policy" "example" {
  user   = aws_iam_user.example.name
  policy = data.aws_iam_policy_document.example.json
}

resource "aws_iam_access_key" "example" {
  user = aws_iam_user.example.name
}

/*
// aws_iam_policy + aws_iam_user_policy_attachment is also fine
resource "aws_iam_policy" "example" {
  policy = data.aws_iam_policy_document.example.json
}

resource "aws_iam_user_policy_attachment" "example" {
  user = aws_iam_user.example.name
  policy_arn = aws_iam_policy.example.arn
}
*/

output "smtp_username" {
  value = aws_iam_access_key.example.secret
}

output "iam_username" {
  value = aws_iam_access_key.example.user
}

output "password" {
  value     = aws_iam_access_key.example.ses_smtp_password_v4
}