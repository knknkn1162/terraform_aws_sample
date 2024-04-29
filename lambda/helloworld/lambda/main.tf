locals {
 suffix = "${uuid()}"
}

module "role4lambda" {
  source = "../role4service"
  services = ["lambda.amazonaws.com"]
  allow_policy_arns = var.allow_policy_arns
}

module "src" {
  source = "./tozip"
  source_dir = var.source_dir
}

resource "aws_lambda_function" "example" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  #filename      = "lambda_function_payload.zip"
  function_name = "lambda-func-${local.suffix}"
  filename = module.src.path
  role          = module.role4lambda.arn
  handler       = var.handler
  source_code_hash = module.src.base64sha256
  runtime = var.runtime
}

output "func_name" {
  value = aws_lambda_function.example.function_name
}

output "invoke_arn" {
  value = aws_lambda_function.example.invoke_arn
}

output "arn" {
  value = aws_lambda_function.example.arn
}