output "url" {
  value = [for k, v in aws_lambda_function_url.example: v.function_url]
}

output "lambda_arn" {
  value = module.lambda.arn
}

output "lambda_invoke_arn" {
  value = module.lambda.invoke_arn
}

output "func_name" {
  value = module.lambda.func_name
}

output "s3_arn" {
  value = module.s3.arn
}