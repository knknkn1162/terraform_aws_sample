variable "vpc_id" {
}

variable "subnet_ids" {
  type = list(string)
}

resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id
}

module "rt4public" {
  source = "../"
  vpc_id = var.vpc_id
  subnet_ids = var.subnet_ids
}
resource "aws_route" "igw" {
  route_table_id            = module.rt4public.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}