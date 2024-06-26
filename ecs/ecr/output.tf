output "repo_url" {
  value = aws_ecr_repository.example.repository_url
  depends_on = [
    null_resource.run_script
  ]
}

output "arn" {
  value = aws_ecr_repository.example.arn
  depends_on = [
    null_resource.run_script
  ]
}

output "registry_id" {
  value = aws_ecr_repository.example.registry_id
}

output "registry_name" {
  value = local.registry_name
}

output "post_ecr_id" {
  value = null_resource.run_script.id
}