variable "vm_spec" {
  type = string
}
variable "vm_cidr" {
  type = string
}

variable "vm_password" {
  type = string
}

module "subnet4vm" {
  source = "./subnet"
  cidr = var.vm_cidr
  vpc_id = module.vpc.id
}

module "vm" {
  source = "./vm"
  vpc_id = module.vpc.id
  vm_subnet_id = module.subnet4vm.id
  natgw_subnet_id = module.subnet4public.id
  vm_spec = var.vm_spec
  vm_cidr = var.vm_cidr
}