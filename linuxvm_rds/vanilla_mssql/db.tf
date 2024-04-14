data "aws_availability_zones" "example" {
}

locals {
  azs = data.aws_availability_zones.example.names
  az_map = {for idx, val in local.azs: idx => val}
}

module "subnets4db" {
  for_each = local.az_map
  source = "./subnet"
  vpc_id = module.vpc.id
  cidr = var.db_cidrs[each.key]
  az = each.value
}

module "vanilla_mssql" {
  source = "./vanilla_mssql"
  # Add subnets to cover at least 2 AZs
  subnet_ids = [for idx, res in module.subnets4db: res.id]
  #db_name = var.db_name
  password = var.db_password
  db_version = var.db_version
  spec = var.db_spec
  edition = var.db_edition
}