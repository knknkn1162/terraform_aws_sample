module "ami4ec2" {
  source = "./ec2/ami/amzn_linux_2023"
}

module "main_ec2" {
  source = "./ec2"
  ami = module.ami4ec2.id
  subnet_id = module.subnet4vpc1public.id
  vm_spec = var.ec2_spec
  sg_ids = [module.sg1.id]
}

module "peer_ec2" {
  source = "./ec2"
  ami = module.ami4ec2.id
  subnet_id = module.subnet4vpc2public.id
  vm_spec = var.ec2_spec
  sg_ids = [module.sg2.id]
}