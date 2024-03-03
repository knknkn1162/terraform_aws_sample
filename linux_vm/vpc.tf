variable "vpc_cidrs" {
}

variable "subnet_cidrs" {}

module "vpc" {
  source = "./vpc"
  cidrs = var.vpc_cidrs
}

module "subnet" {
  source = "./subnet"
  cidrs = var.subnet_cidrs
  vpc_id = module.vpc.id
}