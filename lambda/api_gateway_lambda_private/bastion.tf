variable "bastion_spec" {
  type = string
}
variable "bastion_cidr" {
  type = string
}

module "ami4bastion" {
  source = "./ami/amzn_linux_2023"
}

module "subnet4public" {
  source = "./subnet"
  vpc_id = module.vpc.id
  cidr = var.bastion_cidr
}

module "register_public_subnets" {
  source = "./register_public_subnets"
  vpc_id = module.vpc.id
  subnet_ids = [module.subnet4public.id]
}

module "bastion" {
  source = "./bastion"
  ami = module.ami4bastion.id
  subnet_id = module.subnet4public.id
  vm_spec = var.bastion_spec
}