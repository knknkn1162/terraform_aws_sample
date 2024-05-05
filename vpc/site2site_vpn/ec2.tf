module "ami4vyos" {
  source = "./ec2/ami/vyos1.3"
}

module "vyos" {
  source = "./ec2"
  ami = module.ami4vyos.ami
  subnet_id = module.subnet4vpc2public.id
  vm_spec = var.ec2spec4cgw
  sg_ids = [module.peer_sg4cgw.id]
  associate_public_ip_address = true
  # necessary for VPN
  source_dest_check = false
}