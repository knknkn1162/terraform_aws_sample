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

resource "aws_api_gateway_integration" "mock" {
  http_method = var.http_method
  resource_id = var.resource_id
  rest_api_id = var.rest_api_id
  type        = "MOCK"
  request_templates = {
        "application/json" = var.request_json
  }
}