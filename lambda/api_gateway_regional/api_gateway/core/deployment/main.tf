resource "aws_api_gateway_deployment" "example" {
  rest_api_id = var.rest_api_id
  triggers = {
    redeployment = sha1(jsonencode(var.depends))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "example" {
  deployment_id = aws_api_gateway_deployment.example.id
  rest_api_id   = var.rest_api_id
  stage_name    = var.stage
}