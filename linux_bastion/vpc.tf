variable "vpc_cidr" {
}

module "vpc" {
  source = "./vpc"
  cidr = var.vpc_cidr
}