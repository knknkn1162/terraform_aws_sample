variable "stage" {
  type = string
}

variable "method1" {
  type = string
}

variable "path1" {
  type = string
}


module "route_key1" {
  source = "./api_gateway/route"
  method = var.method1
  path = var.path1
  lambda_invoke_arn = module.lambda.invoke_arn
  api_id = module.api_gateway.id
}

module "api_gateway" {
  source = "./api_gateway"
  stage = var.stage
  triggers = module.route_key1.triggers
}

output "url1" {
  value = "${module.api_gateway.url}/${module.route_key1.route_key}"
}