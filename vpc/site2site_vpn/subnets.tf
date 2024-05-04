
module "subnet4vpc1public" {
  source = "./subnet"
  vpc_id = module.vpc1.id
  cidr = var.public1_cidr
}

module "subnet4vpc2public" {
  source = "./subnet"
  vpc_id = module.vpc2.id
  cidr = var.public2_cidr
}