module "ami4bastion" {
  source = "./ami/amzn_linux_2023"
}

module "bastion" {
  source = "./bastion"
  ami = module.ami4bastion.id
  subnet_id = module.subnet4public.id
  vm_spec = var.bastion_spec
}