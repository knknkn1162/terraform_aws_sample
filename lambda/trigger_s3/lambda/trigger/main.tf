variable "exec_arn" {
  type = string
}

variable "func_name" {
  type = string
}

variable "principal" {
  type = string  
}

# avoid "Invalid permissions on Lambda function" error
resource "aws_lambda_permission" "lambda_permission" {
  #statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.func_name
  principal     = var.principal

  # The /* part allows invocation from any stage, method and resource path
  # within API Gateway.
  // see also https://docs.aws.amazon.com/ja_jp/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "${var.exec_arn}/*"
}