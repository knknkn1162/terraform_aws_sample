module "lambda" {
  source = "./lambda"
  runtime = var.runtime
  handler = var.handler
  source_dir = var.source_dir
  allow_policy_arns = var.allow_policy_arns
}

resource "aws_lambda_function_url" "example" {
  count = var.allow_gen_url ? 1 : 0
  function_name      = module.lambda.func_name
  authorization_type = "NONE"
}