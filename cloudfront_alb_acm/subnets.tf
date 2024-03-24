module "subnet4vm1" {
  source = "./subnet"
  cidr = var.vm1_cidr
  vpc_id = module.vpc.id
  az = "ap-northeast-1a"
}

module "subnet4natgw" {
  source = "./subnet"
  vpc_id = module.vpc.id
  cidr = var.natgw_cidr
  az = "ap-northeast-1a"
}

module "subnet4public1" {
  source = "./subnet"
  vpc_id = module.vpc.id
  cidr = var.public1_cidr
  az = "ap-northeast-1a"
}
module "subnet4public2" {
  source = "./subnet"
  vpc_id = module.vpc.id
  cidr = var.public2_cidr
  az = "ap-northeast-1c"
}