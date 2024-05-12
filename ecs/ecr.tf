module "ecr" {
  source = "./ecr"
  ecr_repo = var.ecr_repo
  original_repo = var.original_repo
}