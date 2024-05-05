module "ami4ec2" {
  source = "./ec2/ami/amzn_linux_2023"
}

module "sg4ec2" {
  source = "./security_group/ec2"
  vpc_id = module.vpc.id
  target_cidr = module.vpc.cidr
}

module "main_ec2" {
  source = "./ec2"
  ami = module.ami4ec2.ami
  subnet_id = module.subnet4ec2.id
  vm_spec = var.ec2_spec
  sg_ids = [module.sg4ec2.id]
}