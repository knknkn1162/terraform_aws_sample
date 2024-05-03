module "lambda" {
  source = "./lambda"
  runtime = var.runtime
  handler = var.handler
  source_dir = var.source_dir
  allow_policy_arns = [
    data.aws_iam_policy.AWSLambdaBasicExecutionRole.arn,
    aws_iam_policy.s3.arn
  ]
  log_group_name = var.log_group_name
}

resource "aws_lambda_function_url" "example" {
  count = var.allow_gen_url ? 1 : 0
  function_name      = module.lambda.func_name
  authorization_type = "NONE"
}

# create instance profile
# see https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-getting-started-instance-profile.html
data "aws_iam_policy" "AWSLambdaBasicExecutionRole" {
  # arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole
  name = "AWSLambdaBasicExecutionRole"
}

data "aws_iam_policy_document" "s3" {
  statement {
    effect = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["${module.s3.arn}/*"]
  }
}

resource "aws_iam_policy" "s3" {
  policy = data.aws_iam_policy_document.s3.json
}