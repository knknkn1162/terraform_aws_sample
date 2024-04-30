variable "api_id" {
  type = string
}

variable "stage" {
  type = string
}

variable "triggers" {
  type = list(string)
}

resource "aws_apigatewayv2_deployment" "example" {
  api_id      = var.api_id

  triggers = {
    redeployment = sha1(join(",", var.triggers))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_apigatewayv2_stage" "example" {
  api_id = var.api_id
  name   = var.stage
  deployment_id = aws_apigatewayv2_deployment.example.id
}

output "url" {
  value = aws_apigatewayv2_stage.example.invoke_url
}

output "exec_arn" {
  value = aws_apigatewayv2_stage.example.execution_arn
}

output "id" {
  value = aws_apigatewayv2_deployment.example.id
}