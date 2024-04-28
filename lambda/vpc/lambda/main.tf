locals {
 suffix = "${uuid()}"
}

module "iam_role" {
  source = "../iam_role"
  services = ["lambda.amazonaws.com"]
  managed_policy_arns = var.allow_policy_arns
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
  role          = module.iam_role.arn
  source_code_hash = module.src.base64sha256
  runtime = var.runtime
  handler = var.handler
  vpc_config {
    subnet_ids = var.subnet_ids
    security_group_ids = var.sg_ids
  }
}

output "func_name" {
  value = aws_lambda_function.example.function_name
}