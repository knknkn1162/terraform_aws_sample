
output "test_result" {
  value = {for k, v in aws_lambda_invocation.example: k => v.result}
}

output "url" {
  value = aws_lambda_function_url.test_latest.function_url
}