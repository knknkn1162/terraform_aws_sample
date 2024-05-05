module "vpc" {
  source = "./vpc"
  cidr = var.vpc_cidr
}

module "subnet4public" {
  source = "./subnet"
  vpc_id = module.vpc.id
  cidr = var.public_cidr
}

module "igw" {
  source = "./route_table/igw"
  route_table_id = module.subnet4public.rt_id
  vpc_id = module.vpc.id
}