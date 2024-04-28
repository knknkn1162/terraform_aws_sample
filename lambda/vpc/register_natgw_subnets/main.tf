# egress only
module "natgw" {
  source = "./natgw"
  subnet_id = var.natgw_subnet_id
}

locals {
  private_subnet_id_map = {for k,v in var.private_subnet_ids: k => v}
}

# route table(private)
resource "aws_route_table" "example" {
  vpc_id = var.vpc_id
}

resource "aws_route" "private" {
  route_table_id = aws_route_table.example.id
  nat_gateway_id = module.natgw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "example" {
  for_each = local.private_subnet_id_map
  subnet_id = each.value
  route_table_id = aws_route_table.example.id
}

output "public_ip" {
  value = module.natgw.public_ip
}

output "private_ip" {
  value = module.natgw.private_ip
}