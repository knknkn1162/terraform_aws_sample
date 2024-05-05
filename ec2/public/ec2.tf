module "ami4ec2" {
  source = "./ec2/ami/amzn_linux_2023"
}

module "ec2" {
  source = "./ec2"
  ami = module.ami4ec2.id
  subnet_id = module.subnet4public.id
  vm_spec = var.ec2_spec
  sg_ids = [module.sg.id]
}