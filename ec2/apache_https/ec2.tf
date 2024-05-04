module "ami4ec2" {
  source = "./ec2/ami/amzn_linux_2023"
}

module "ec2" {
  source = "./ec2"
  ami = module.ami4ec2.id
  subnet_id = module.subnet4public.id
  vm_spec = var.ec2_spec
  sg_ids = [module.sg.id]
  domain = local.domain
}

module "register_a_record" {
  source = "./dns_a_record"
  root_domain = var.root_domain
  prefix = var.prefix_domain
  ip = module.ec2.public_ip
}