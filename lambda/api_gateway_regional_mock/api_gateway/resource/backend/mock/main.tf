variable "rest_api_id" {
  type = string
}

variable "resource_id" {
  type = string
}

variable "http_method" {
  type = string
}

variable "request_json" {
  type = string
}

variable "response_json" {
  type = string
}

resource "aws_api_gateway_integration" "mock" {
  http_method = var.http_method
  resource_id = var.resource_id
  rest_api_id = var.rest_api_id
  type        = "MOCK"
  request_templates = {
        "application/json" = var.request_json
  }
}

resource "aws_api_gateway_method_response" "response_200" {
  rest_api_id = var.rest_api_id
  resource_id = var.resource_id
  http_method = aws_api_gateway_integration.mock.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "MyDemoIntegrationResponse" {
  rest_api_id = var.rest_api_id
  resource_id = var.resource_id
  http_method = aws_api_gateway_integration.mock.http_method
  status_code = aws_api_gateway_method_response.response_200.status_code

  response_templates = {
    "application/json" = var.response_json
  }
}

output "integration_id" {
  value = aws_api_gateway_integration.mock.id
}