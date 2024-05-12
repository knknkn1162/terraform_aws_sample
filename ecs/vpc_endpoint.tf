module "vpc_endpoint_ecr" {
  source = "./vpc_endpoint/ecr"
  vpc_id = module.vpc.id
  sg_ids = module.sg4private.id
  subnet_ids = [module.subnet4private1.id, module.subnet4private2.id]
}