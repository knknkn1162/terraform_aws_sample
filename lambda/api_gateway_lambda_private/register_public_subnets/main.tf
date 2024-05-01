variable "vpc_id" {
}

variable "subnet_ids" {
  type = list(string)
}

resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id
}

module "rt_gw" {
  source = "./rt_gw"
  vpc_id = var.vpc_id
  igw_id = aws_internet_gateway.igw.id
  subnet_ids = var.subnet_ids
}