module "s3" {
  source = "./s3"
}

module "codecommit" {
  source = "./codecommit"
  repo = var.repo
  trigger_arn = module.s3.arn
}