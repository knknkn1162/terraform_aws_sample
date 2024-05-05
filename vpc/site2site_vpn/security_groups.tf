# cgw
module "peer_sg4cgw" {
  source = "./security_group/cgw"
  vpc_id = module.vpc2.id
}