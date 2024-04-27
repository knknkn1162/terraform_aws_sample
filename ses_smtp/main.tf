module "domain" {
  source = "./domain"
  domain = var.domain
  enable_verification = var.enable_verification
}

module "smtp_user" {
  source = "./smtp_user"
}