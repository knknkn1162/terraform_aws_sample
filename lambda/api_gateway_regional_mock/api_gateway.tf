module "api_gateway" {
  source = "./api_gateway"
}

module "path1" {
  source = "./api_gateway/path1"
  parent_id = module.api_gateway.root_id
  rest_api_id = module.api_gateway.rest_api_id
}

module "deployment" {
  source = "./api_gateway/deployment"
  rest_api_id = module.api_gateway.rest_api_id
  triggers = module.path1.dependent_ids
  stage = var.stage
}

output "base_url" {
  value = module.deployment.url
}

output "path1_url" {
  value = "${module.deployment.url}${module.deployment.stage}${module.path1.path}"
}