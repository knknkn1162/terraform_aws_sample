
locals {
  paths_map = {for val, val in var.test_json_paths: val => val}
}

resource "aws_lambda_invocation" "example" {
  for_each = local.paths_map
  function_name = module.lambda.func_name
  input = file(each.value)
}