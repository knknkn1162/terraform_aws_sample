variable "bastion_spec" {
  type = string
}
variable "bastion_cidr" {
  type = string
}


data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

module "subnet4bastion" {
  source = "./subnet"
  vpc_id = module.vpc.id
  cidr = var.bastion_cidr
}

module "bastion" {
  source = "./bastion"
  ami = data.aws_ami.amzn-linux-2023-ami.id
  subnet_id = module.subnet4bastion.id
  vm_spec = var.bastion_spec
}