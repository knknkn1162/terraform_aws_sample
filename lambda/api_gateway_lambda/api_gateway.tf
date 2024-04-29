module "api_gateway" {
  source = "./api_gateway"
  is_edge = var.is_edge
}

module "path1" {
  source = "./api_gateway/path1"
  parent_id = module.api_gateway.root_id
  rest_api_id = module.api_gateway.rest_api_id
  invoke_arn = module.lambda.invoke_arn
}

module "deployment" {
  source = "./api_gateway/deployment"
  rest_api_id = module.api_gateway.rest_api_id
  triggers = module.path1.dependent_ids
  stage = var.stage
}