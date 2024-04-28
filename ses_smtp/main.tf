module "domain" {
  source = "./domain"
  domain = var.domain
  enable_verification = var.enable_verification
}


module "new_smtp_user" {
  source = "./new_smtp_user"
}
