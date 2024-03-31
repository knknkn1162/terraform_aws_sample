module "register_public_subnets" {
  source = "./alb2backend_vm/register_public_subnets"
  vpc_id = module.vpc.id
  subnet_ids = [
    module.subnet4public1.id,
    module.subnet4public2.id,
    module.subnet4natgw.id
  ]
}