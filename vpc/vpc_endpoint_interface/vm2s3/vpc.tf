variable "vpc_cidr" {
}

module "vpc" {
  source = "./vpc"
  cidr = var.vpc_cidr
  enable_private_dns = true
}

module "subnet4public" {
  source = "./subnet"
  vpc_id = module.vpc.id
  cidr = var.public_cidr
}