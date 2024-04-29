output "base_url" {
  value = module.deployment.url
}

output "path1_url" {
  value = "${module.deployment.url}${module.deployment.stage}${module.path1.path}"
}