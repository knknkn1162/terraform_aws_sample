
module "subnet4vpc1public" {
  source = "./subnet"
  vpc_id = module.vpc1.id
  cidr = var.public1_cidr
  is_public = true
}


module "subnet4vpc1private" {
  source = "./subnet"
  vpc_id = module.vpc1.id
  cidr = var.private1_cidr
  is_public = false
}

module "subnet4vpc2public" {
  source = "./subnet"
  vpc_id = module.vpc2.id
  cidr = var.public2_cidr
  is_public = true
}

module "subnet4vpc2private" {
 source = "./subnet"
  vpc_id = module.vpc2.id
  cidr = var.private2_cidr
  is_public = false
}


module "route_vgw" {
  source = "./rt2subnets/route/vgw"
  vgw_id = module.vpn.vpn_gateway_id
  rt_id = module.subnet4vpc1public.rt_id
}

module "route_cgw" {
  source = "./rt2subnets/route/cgw"
  rt_id = module.subnet4vpc2public.rt_id
  nic_id = module.vyos.nic_id
  vpc_cidr = module.vpc1.cidr
}