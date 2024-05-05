
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

module "subnet4vpc1private" {
  source = "./subnet"
  vpc_id = module.vpc1.id
  cidr = var.private1_cidr
  is_public = false
}

module "subnet4vpc2private" {
 source = "./subnet"
  vpc_id = module.vpc2.id
  cidr = var.private2_cidr
  is_public = false
}

module "ami4ec2" {
  source = "./ec2/ami/amzn_linux_2023"
}

# TODO: test `ping ${module.peer_ec2.private_ip}`
module "main_ec2" {
  source = "./ec2"
  ami = module.ami4ec2.ami
  subnet_id = module.subnet4vpc1private.id
  vm_spec = var.ec2spec4test
  sg_ids = [module.main_sg4testec2.id]
  allow_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ]
}
module "peer_ec2" {
  source = "./ec2"
  ami = module.ami4ec2.ami
  subnet_id = module.subnet4vpc2private.id
  vm_spec = var.ec2spec4test
  sg_ids = [module.peer_sg4testec2.id]
}