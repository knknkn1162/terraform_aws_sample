module "alb" {
  source = "./alb"
  vpc_id = module.vpc.id
  subnet_ids = [module.subnet4public1.id, module.subnet4public2.id]
  sg_id = module.sg4public.id
}

# necessary when pull from ecr
module "vpc_endpoint_s3" {
  source = "./vpc_endpoint/s3"
  vpc_id = module.vpc.id
  rt_ids = [
    module.subnet4private1.rt_id,
    module.subnet4private2.rt_id
  ]
}

module "vpc_endpoint_ecr" {
  source = "./vpc_endpoint/ecr"
  vpc_id = module.vpc.id
  sg_id = module.sg4private.id
  subnet_ids = [module.subnet4private1.id, module.subnet4private2.id]
}

module "vpc_endpoint_cloudwatch" {
  source = "./vpc_endpoint/cloudwatch"
  vpc_id = module.vpc.id
  sg_id = module.sg4private.id
  subnet_ids = [module.subnet4private1.id, module.subnet4private2.id]
}

module "ecs" {
  source = "./ecs"
  tg_arn = module.alb.tg_arn
  ecr_repo_url = module.ecr.repo_url
  sg_id = module.sg4private.id
  subnet_ids = [
    module.subnet4private1.id,
    module.subnet4private2.id
  ]
  cnt = var.container_cnt
}