variable "vpc_cidr" {
}

module "vpc" {
  source = "./vpc"
  cidr = var.vpc_cidr
}

module "subnet4public" {
  source = "./subnet"
  vpc_id = module.vpc.id
  cidr = var.public_cidr
}