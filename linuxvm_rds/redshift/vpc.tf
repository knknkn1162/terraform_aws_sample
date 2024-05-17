module "vpc" {
  source = "./vpc"
  cidr = var.vpc_cidr
}

module "subnet4public" {
  source = "./subnet"
  vpc_id = module.vpc.id
  cidr = var.public_cidr
}

module "subnets4db" {
  for_each = local.db_cidr_map
  source = "./subnet"
  cidr = each.value
  vpc_id = module.vpc.id
}

module "igw" {
  source = "./subnet/route/igw"
  vpc_id = module.vpc.id
  rt_ids = concat(
    #[for k, v in module.subnets4db: v.rt_id],
    [module.subnet4public.rt_id],
  )
}