variable "parent_id" {
  type = string
}

variable "rest_api_id" {
  type = string
}

## path1
module "path" {
  source = "../core/path"
  parent_id = var.parent_id
  rest_api_id = var.rest_api_id
  path = "path1"
  http_method = "GET"
  stage = "dev"
}

module "backend" {
  source = "../core/integration/mock"
  resource_id = module.path.resource_id
  rest_api_id =var.rest_api_id
  http_method = module.path.http_method
  request_json = jsonencode({
    example = "value"
  })
}