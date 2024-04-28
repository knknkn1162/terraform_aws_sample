
module "subnet4public" {
  source = "./subnet"
  cidr = var.public_cidr
  vpc_id = module.vpc.id
}

module "register_public_subnets" {
  source = "./register_public_subnets"
  vpc_id = module.vpc.id
  subnet_ids = [
    module.subnet4public.id
  ]
}