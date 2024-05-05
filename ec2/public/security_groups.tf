# peering test
module "sg" {
  source = "./security_group"
  vpc_id = module.vpc.id
  #target_cidr = 
}