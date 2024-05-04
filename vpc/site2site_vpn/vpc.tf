module "vpc1" {
  source = "./vpc"
  cidr = var.vpc1_cidr
}

module "vpc2" {
  source = "./vpc"
  cidr = var.vpc2_cidr
}

# main
module "vpn_gateway" {
  source = "./vpn_gateway"
  vpc_id = module.vpc1.id
}

# peer
module "customer_gateway" {
  source = "./customer_gateway"
  public_ip = module.vyos.public_ip
}