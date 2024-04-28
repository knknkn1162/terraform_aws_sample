module "lambda" {
  source = "./lambda"
  runtime = var.runtime
  handler = var.handler
  source_dir = var.source_dir
}

resource "aws_lambda_function_url" "test_latest" {
  function_name      = module.lambda.func_name
  authorization_type = "NONE"
}