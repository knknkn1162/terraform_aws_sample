
# for test
module "main_sg4testec2" {
  source = "./security_group/testec2"
  vpc_id = module.vpc1.id
}

module "peer_sg4testec2" {
  source = "./security_group/testec2"
  vpc_id = module.vpc2.id
  icmp_target_cidr = module.vpc1.cidr
}

module "peer_subnet4private" {
 source = "./subnet"
  vpc_id = module.vpc2.id
  cidr = var.private2_cidr
  is_public = false
}
module "route_cgw4test" {
  source = "./rt2subnets/route/cgw"
  rt_id = module.peer_subnet4private.rt_id
  nic_id = module.vyos.nic_id
  vpc_cidr = module.vpc1.cidr
}

module "ami4ec2" {
  source = "./ec2/ami/amzn_linux_2023"
}

# TODO: test `ping ${module.peer_ec2.private_ip}`
module "main_ec2" {
  source = "./ec2"
  ami = module.ami4ec2.ami
  subnet_id = module.subnet4vpc1public.id
  vm_spec = var.ec2spec4test
  sg_ids = [module.main_sg4testec2.id]
  associate_public_ip_address = true
  allow_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ]
}
module "peer_ec2" {
  source = "./ec2"
  ami = module.ami4ec2.ami
  subnet_id = module.peer_subnet4private.id
  vm_spec = var.ec2spec4test
  sg_ids = [module.peer_sg4testec2.id]
}