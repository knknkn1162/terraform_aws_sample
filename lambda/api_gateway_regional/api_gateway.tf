module "api_gateway" {
  source = "./api_gateway"
  stage = "dev"
}

## path1
module "path1" {
  source = "./api_gateway/path"
  parent_id = module.api_gateway.root_id
  rest_api_id = module.api_gateway.rest_api_id
  path = "get"
  http_method = "GET"
  stage = "dev"
}

module "backend1" {
  source = "./api_gateway/integration/mock"
  resource_id = module.path1.resource_id
  rest_api_id = module.api_gateway.rest_api_id
  http_method = module.path1.http_method
  request_json = jsonencode({
    example = "value"
  })
}