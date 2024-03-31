variable "vpc_id" {
}
variable "subnet_ids4rt" {
  type = list(string)
}
variable "subnet_id4natgw" {
}

module "rt4vm" {
  source = "../"
  vpc_id = var.vpc_id
  subnet_ids = var.subnet_ids4rt
}
# egress only
module "natgw" {
  source = "../../natgw"
  subnet_id = var.subnet_id4natgw
}

resource "aws_route" "private" {
  route_table_id = module.rt4vm.id
  nat_gateway_id = module.natgw.id
  destination_cidr_block = "0.0.0.0/0"
}

output "id" {
  value = module.rt4vm.id
}