variable vpc_endpoint_ids {
  type = list(string)
}
 
locals {
  endpoint_type = "PRIVATE"
}

resource "aws_api_gateway_rest_api" "example" {
  name = "gateway-${uuid()}"
  endpoint_configuration {
    # defaults to EDGE
    types = [local.endpoint_type]
    vpc_endpoint_ids = var.vpc_endpoint_ids
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

// Execution ARN part to be used in lambda_permission's source_arn when allowing API Gateway to invoke a Lambda function
output "exec_arn" {
  value = aws_api_gateway_rest_api.example.execution_arn
}