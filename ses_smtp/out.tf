output "iam_username" {
  value = module.smtp_user.iam_username
}

output "smtp_username" {
  value = module.smtp_user.smtp_username
  sensitive = true
}

output "password" {
  value = module.smtp_user.password
  sensitive = true
}