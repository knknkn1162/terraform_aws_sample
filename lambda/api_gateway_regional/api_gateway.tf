module "api_gateway" {
  source = "./api_gateway"
}

module "path1" {
  source = "./api_gateway/path1"
  parent_id = module.api_gateway.root_id
  rest_api_id = module.api_gateway.rest_api_id
}