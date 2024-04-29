variable "rest_api_id" {
  type = string
}

variable "resource_id" {
  type = string
}

variable "http_method" {
  type = string
}

variable "invoke_arn" {
  type = string
}

resource "aws_api_gateway_integration" "lambda" {
  rest_api_id             = var.rest_api_id
  resource_id             = var.resource_id
  http_method             = var.http_method
  # For Lambda integrations, you must use the HTTP method of POST for the integration request,
  # according to the specification of the Lambda service action for function invocations.
  # see AWS lambda API spec. -> https://docs.aws.amazon.com/lambda/latest/api/API_Invoke.html
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.invoke_arn
}

resource "aws_api_gateway_method_response" "response_200" {
  rest_api_id = var.rest_api_id
  resource_id = var.resource_id
  http_method = var.http_method
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }
}

output "dependent_ids" {
  value = [
    aws_api_gateway_integration.lambda.id,
    aws_api_gateway_method_response.response_200.id
  ]
}