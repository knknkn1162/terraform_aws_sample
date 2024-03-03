variable "bastion_cidrs" {}

resource "aws_internet_gateway" "igw" {
  vpc_id = module.vpc.id
}

module "rt_gateway" {
  source = "./rt_gateway"
  vpc_id = module.vpc.id
  igw_id = aws_internet_gateway.igw.id
  subnet_ids = [module.subnet4bastion.id]
}