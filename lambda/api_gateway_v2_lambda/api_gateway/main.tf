variable "triggers" {
  type = list(string)
}

module "def" {
  source = "./definition"
}

module "deploy" {
  source = "./deployment"
  api_id = module.def.id
  stage = var.stage
  triggers = var.triggers
}

output "url" {
  value = module.deploy.url
}

output "exec_arn" {
  value = module.deploy.exec_arn
}

output "id" {
  value = module.def.id
}

output "deployment_id" {
  value = module.deploy.id
}