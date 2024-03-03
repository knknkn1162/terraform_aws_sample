variable "vpc_cidrs" {
}

variable "vm_cidrs" {}

module "vpc" {
  source = "./vpc"
  cidrs = var.vpc_cidrs
}

module "subnet4vm" {
  source = "./subnet"
  cidrs = var.vm_cidrs
  vpc_id = module.vpc.id
}