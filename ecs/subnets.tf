
module "subnet4public1" {
  source = "./subnet"
  vpc_id = module.vpc.id
  cidr = var.public1_cidr
}

module "subnet4public2" {
  source = "./subnet"
  vpc_id = module.vpc.id
  cidr = var.public2_cidr
}

module "igw4public1" {
  source = "./subnet/route/igw"
  vpc_id = module.vpc.id
  rt_id = module.subnet4public1.rt_id
}

module "igw4public2" {
  source = "./subnet/route/igw"
  vpc_id = module.vpc.id
  rt_id = module.subnet4public1.rt_id
}

module "sg4public" {
  source = "./security_group/public"
  vpc_id = module.vpc.id
}

# priv
module "subnet4private1" {
  source = "./subnet"
  vpc_id = module.vpc.id
  cidr = var.public1_cidr
}

module "subnet4private2" {
  source = "./subnet"
  vpc_id = module.vpc.id
  cidr = var.public2_cidr
}

module "sg4private" {
  source = "./security_group/private"
  vpc_id = module.vpc.id
}
