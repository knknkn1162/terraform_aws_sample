variable "is_edge" {
  type = bool
}

locals {
  endpoint_type = var.is_edge ? "EDGE" : "REGIONAL"
}

resource "aws_api_gateway_rest_api" "example" {
  name = "gateway-${uuid()}"
  endpoint_configuration {
    # defaults to EDGE
    types = [local.endpoint_type]
  }
}

output "root_id" {
  value = aws_api_gateway_rest_api.example.root_resource_id
}

output "rest_api_id" {
  value = aws_api_gateway_rest_api.example.id
}

output "body" {
  value = aws_api_gateway_rest_api.example.body
}