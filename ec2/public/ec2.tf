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

resource "local_file" "name" {
  content = module.ec2.privkey
  filename = var.privkey_filepath
  file_permission = "0400"
}