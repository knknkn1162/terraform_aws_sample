module "ami4ec2" {
  source = "./ec2/ami/vyos1.3"
}

module "vyos" {
  source = "./ec2"
  ami = module.ami4ec2.ami
  subnet_id = module.subnet4vpc2public.id
  vm_spec = var.ec2_spec
  sg_ids = [module.sg2cgw.id]
  associate_public_ip_address = true
  # necessary for VPN
  source_dest_check = false
}

module "testec2" {
  source = "./ec2"
  ami = module.ami4ec2.ami
  subnet_id = module.subnet4vpc2private.id
  vm_spec = var.ec2_spec
  sg_ids = [module.sg2testec2.id]
}