variable "vm_spec" {
  type = string
}
variable "vm_cidr" {
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
  subnet_id = module.subnet4vm.id
  vm_spec = var.vm_spec
  vm_cidr = var.vm_cidr
}