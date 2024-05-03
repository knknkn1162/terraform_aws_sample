# peering test
module "sg1" {
  source = "./security_group"
  vpc_id = module.vpc1.id
  target_cidr = var.vpc2_cidr
}

module "sg2" {
  source = "./security_group"
  vpc_id = module.vpc2.id
  target_cidr = var.vpc1_cidr
}