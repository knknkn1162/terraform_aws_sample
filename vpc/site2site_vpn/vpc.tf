module "vpc1" {
  source = "./vpc"
  cidr = var.vpc1_cidr
}

module "vpc2" {
  source = "./vpc"
  cidr = var.vpc2_cidr
}

module "vpn" {
  source = "./vpn"
  vpc_id = module.vpc1.id
  cgw_public_ip = module.vyos.public_ip
}