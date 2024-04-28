
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

module "register_egress_subnets" {
  source = "./register_natgw_subnets"
  vpc_id = module.vpc.id
  natgw_subnet_id = module.subnet4public.id
  private_subnet_ids = [
    module.subnet4lambda.id
  ]
  depends_on = [
    module.register_public_subnets
  ]
}