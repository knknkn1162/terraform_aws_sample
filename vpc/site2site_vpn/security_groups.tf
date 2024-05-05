# cgw
module "sg2cgw" {
  source = "./security_group/cgw"
  vpc_id = module.vpc2.id
}

module "sg2testec2" {
  source = "./security_group/testec2"
  vpc_id = module.vpc2.id
  icmp_target_cidr = module.vpc1.cidr
}