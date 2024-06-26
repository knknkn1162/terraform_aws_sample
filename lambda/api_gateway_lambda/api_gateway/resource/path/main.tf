resource "aws_api_gateway_resource" "example" {
  parent_id   = var.parent_id
  path_part   = var.path
  rest_api_id = var.rest_api_id
}

resource "aws_api_gateway_method" "example" {
  authorization = "NONE"
  http_method   = var.http_method
  resource_id   = aws_api_gateway_resource.example.id
  rest_api_id   = var.rest_api_id
}

output "dependent_ids" {
  value = [
    aws_api_gateway_resource.example.id,
    aws_api_gateway_method.example.id
  ]
}

output "resource_id" {
  value = aws_api_gateway_resource.example.id
}

output "http_method" {
  value = aws_api_gateway_method.example.http_method
}

output "method_id" {
  value = aws_api_gateway_method.example.id
}

output "path" {
  value = aws_api_gateway_resource.example.path
}