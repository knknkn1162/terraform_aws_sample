module "vpc1" {
  source = "./vpc"
  cidr = var.vpc1_cidr
}

module "vpc2" {
  source = "./vpc"
  cidr = var.vpc2_cidr
}