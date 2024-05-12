module "user_info" {
  source = "./userinfo"
}

data "aws_availability_zones" "current" {
  filter {
    name = "region-name"
    values = [module.user_info.region]
  }
}

locals {
  az0_id = data.aws_availability_zones.current.zone_ids[0]
  az1_id = data.aws_availability_zones.current.zone_ids[1]
}

module "subnet4public1" {
  source = "./subnet"
  vpc_id = module.vpc.id
  cidr = var.public1_cidr
  az_id = local.az0_id
}

module "subnet4public2" {
  source = "./subnet"
  vpc_id = module.vpc.id
  cidr = var.public2_cidr
  az_id = local.az1_id
}

module "igws" {
  source = "./subnet/route/igw"
  vpc_id = module.vpc.id
  rt_ids = [
    module.subnet4public1.rt_id,
    module.subnet4public2.rt_id
  ]
}


module "sg4public" {
  source = "./security_group/public"
  vpc_id = module.vpc.id
}

# priv
module "subnet4private1" {
  source = "./subnet"
  vpc_id = module.vpc.id
  cidr = var.private1_cidr
  az_id = local.az0_id
}

module "subnet4private2" {
  source = "./subnet"
  vpc_id = module.vpc.id
  cidr = var.private2_cidr
  az_id = local.az1_id
}

module "sg4private" {
  source = "./security_group/private"
  vpc_id = module.vpc.id
}
