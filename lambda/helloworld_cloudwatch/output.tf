
output "test_result" {
  value = {for k, v in aws_lambda_invocation.example: k => v.result}
}

output "url" {
  value = [for k, v in aws_lambda_function_url.example: v.function_url]
}

output "arn" {
  value = module.lambda.arn
}

output "invoke_arn" {
  value = module.lambda.invoke_arn
}

output "func_name" {
  value = module.lambda.func_name
}