variable "lambda_invoke_arn" {
  type = string
}

variable "api_id" {
  type = string
}

variable "method" {
  type = string
}

variable "path" {
  type = string
}

locals {
  route_key = "${var.method} ${var.path}"
}

resource "aws_apigatewayv2_integration" "example" {
  api_id           = var.api_id
  # lambda
  integration_type = "AWS_PROXY"
  # default
  # connection_type = "INTERNET"
  integration_method = "POST"
  integration_uri = var.lambda_invoke_arn
}

resource "aws_apigatewayv2_route" "example" {
  api_id    = var.api_id
  route_key = local.route_key
  // IntegrationID is the identifier of an aws_apigatewayv2_integration resource.
  target = "integrations/${aws_apigatewayv2_integration.example.id}"
}

output "triggers" {
  value = tolist([
    jsonencode(aws_apigatewayv2_integration.example),
    jsonencode(aws_apigatewayv2_route.example),
  ])
}

output "route_key" {
  value = aws_apigatewayv2_route.example.route_key
}

output "path" {
  value = var.path
}