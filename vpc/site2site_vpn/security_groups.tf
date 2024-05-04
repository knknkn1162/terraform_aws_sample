# peering test
module "sg1" {
  source = "./security_group"
  vpc_id = module.vpc1.id
}

module "sg2" {
  source = "./security_group"
  vpc_id = module.vpc2.id
}