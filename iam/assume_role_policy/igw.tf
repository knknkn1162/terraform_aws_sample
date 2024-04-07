resource "aws_internet_gateway" "igw" {
  vpc_id = module.vpc.id
}

module "rt_gw" {
  source = "./rt_gw"
  vpc_id = module.vpc.id
  igw_id = aws_internet_gateway.igw.id
  subnet_ids = [module.subnet4vm.id]
}