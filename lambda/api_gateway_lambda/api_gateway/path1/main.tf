variable "parent_id" {
  type = string
}

variable "rest_api_id" {
  type = string
}

variable "invoke_arn" {
  type = string
}

module "path" {
  source = "../resource/path"
  parent_id = var.parent_id
  rest_api_id = var.rest_api_id
  path = "path1"
  http_method = "GET"
}

module "backend" {
  source = "../resource/backend/lambda"
  resource_id = module.path.resource_id
  rest_api_id =var.rest_api_id
  http_method = module.path.http_method
  invoke_arn = var.invoke_arn
}

output "dependent_ids" {
  value = concat(
    module.path.dependent_ids,
    module.backend.dependent_ids
  )
}

output "path" {
  value = module.path.path
}