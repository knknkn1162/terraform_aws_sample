module "vpc" {
  source = "./vpc"
  cidr = var.vpc_cidr
}

/*
# egress only
module "natgw" {
  source = "./natgw"
  subnet_id = module.subnet4public.id
}
*/