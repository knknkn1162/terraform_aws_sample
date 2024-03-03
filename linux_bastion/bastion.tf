variable "bastion_spec" {
  type = string
}
variable "bastion_cidr" {
  type = string
}

module "ami4bastion" {
  source = "./ami/amzn_linux_2023"
}

module "subnet4bastion" {
  source = "./subnet"
  vpc_id = module.vpc.id
  cidr = var.bastion_cidr
}

module "bastion" {
  source = "./bastion"
  ami = module.ami4bastion.id
  subnet_id = module.subnet4bastion.id
  vm_spec = var.bastion_spec
}