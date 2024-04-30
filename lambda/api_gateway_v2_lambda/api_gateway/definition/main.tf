resource "aws_apigatewayv2_api" "example" {
  name          = "api-gateway-v2-${uuid()}"
  protocol_type = "HTTP"
}

output "id" {
  value = aws_apigatewayv2_api.example.id
}