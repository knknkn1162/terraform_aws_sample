variable "vm_cidr" {
  type = string
}

module "subnet4vm" {
  source = "./subnet"
  cidr = var.vm_cidr
  vpc_id = module.vpc.id
}