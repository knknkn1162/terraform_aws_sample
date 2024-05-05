variable "cidr" {
}

variable "vpc_id" {
}

variable "is_public" {
  type = bool
}

resource "aws_subnet" "example" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr
}

module "register_subnets" {
  source = "../rt2subnets"
  vpc_id = var.vpc_id
  subnet_ids = [
    aws_subnet.example.id
  ]
}

module "igw" {
  count = var.is_public ? 1 : 0
  source = "../rt2subnets/route/igw"
  route_table_id = module.register_subnets.rt_id
  vpc_id = var.vpc_id
}

output "id" {
  value = aws_subnet.example.id
}

output "rt_id" {
  value = module.register_subnets.rt_id
}