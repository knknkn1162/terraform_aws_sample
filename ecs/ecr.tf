module "ecr" {
  source = "./ecr"
  ecr_repo = var.ecr_repo
}