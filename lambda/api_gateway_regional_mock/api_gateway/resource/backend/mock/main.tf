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
  // pass thru
  response_models = {
    // aws_api_gateway_model for custom model
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "example" {
  rest_api_id = var.rest_api_id
  resource_id = var.resource_id
  http_method = aws_api_gateway_integration.mock.http_method
  status_code = aws_api_gateway_method_response.response_200.status_code

  response_templates = {
    "application/json" = var.response_json
  }
}

output "dependent_ids" {
  value = [
    aws_api_gateway_integration.mock.id,
    aws_api_gateway_method_response.response_200.id,
    aws_api_gateway_integration_response.example.id
  ]
}