variable "vpc_cidr" {
}

variable "vm_cidr" {}

module "vpc" {
  source = "./vpc"
  cidr = var.vpc_cidr
}

module "subnet4vm" {
  source = "./subnet"
  cidr = var.vm_cidr
  vpc_id = module.vpc.id
}