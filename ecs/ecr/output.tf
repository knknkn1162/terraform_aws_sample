output "url" {
  value = aws_ecr_repository.example.repository_url
}

output "arn" {
  value = aws_ecr_repository.example.arn
}

output "registry_id" {
  value = aws_ecr_repository.example.registry_id
}

output "registry_name" {
  value = local.registry_name
}