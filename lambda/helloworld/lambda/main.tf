module "service" {
  source = "../service"
  services = ["lambda.amazonaws.com"]
}

locals {
 suffix = "${uuid()}"
}

resource "aws_iam_role" "example" {
  name = "iam-role-${uuid()}"
  assume_role_policy = module.service.json
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
  role          = aws_iam_role.example.arn
  handler       = var.handler
  source_code_hash = module.src.base64sha256
  runtime = var.runtime
}

output "func_name" {
  value = aws_lambda_function.example.function_name
}