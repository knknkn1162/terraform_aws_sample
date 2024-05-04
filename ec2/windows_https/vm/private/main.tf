variable "vpc_id" {
}

variable "vm_subnet_id" {
}
variable "natgw_subnet_id" { 
}


# egress only
module "natgw" {
  source = "../../natgw"
  subnet_id = var.natgw_subnet_id
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
  subnet_id = var.vm_subnet_id
  route_table_id = aws_route_table.example.id
}

output "natgw_public_ip" {
  value = module.natgw.public_ip
}
