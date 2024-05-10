module "vpc" {
  source = "./vpc"
  cidr = var.vpc_cidr
}

module "subnet4public" {
  source = "./subnet"
  vpc_id = module.vpc.id
  cidr = var.public_cidr
}

module "igw4rt4public" {
  source = "./subnet/route/igw"
  vpc_id = module.vpc.id
  route_table_id = module.subnet4public.rt_id
}