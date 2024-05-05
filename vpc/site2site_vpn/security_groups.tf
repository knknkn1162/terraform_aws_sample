# cgw
module "peer_sg4cgw" {
  source = "./security_group/cgw"
  vpc_id = module.vpc2.id
}

module "main_sg4testec2" {
  source = "./security_group/testec2"
  vpc_id = module.vpc1.id
}

module "peer_sg4testec2" {
  source = "./security_group/testec2"
  vpc_id = module.vpc2.id
  icmp_target_cidr = module.vpc1.cidr
}