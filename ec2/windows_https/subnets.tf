
module "subnet4public" {
  source = "./subnet"
  vpc_id = module.vpc.id
  cidr = var.public_cidr
}