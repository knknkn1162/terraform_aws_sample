variable "vpc_id" {
}

variable "igw_id" {}

# when set(string), The "for_each" map includes keys derived from resource attributes that cannot be determined until apply, 
# and so Terraform cannot determine the full set of keys that will identify the instances of this resource.
variable "subnet_ids" {
  type = list(string)
}

locals {
  subnet_map = { for idx, val in var.subnet_ids : idx => val }
}

resource "aws_route_table" "example" {
  vpc_id = var.vpc_id
}

resource "aws_route" "route" {
  route_table_id            = aws_route_table.example.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = var.igw_id
}

resource "aws_route_table_association" "example" {
  for_each = local.subnet_map
  subnet_id = each.value
  route_table_id = aws_route_table.example.id
}

output "rt_id" {
  value = aws_route_table.example.id
}