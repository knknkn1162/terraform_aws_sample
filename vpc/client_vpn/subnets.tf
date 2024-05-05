
module "subnet4ec2" {
  source = "./subnet"
  vpc_id = module.vpc.id
  cidr = var.private1_cidr
}

module "subnet4vpn_client" {
  source = "./subnet"
  vpc_id = module.vpc.id
  cidr = var.private2_cidr
}

module "register_subnets" {
  source = "./route_table"
  vpc_id = module.vpc.id
  subnet_ids = [
    module.subnet4ec2.id,
  ]
}