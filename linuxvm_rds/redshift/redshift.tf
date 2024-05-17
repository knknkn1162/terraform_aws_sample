locals {
  db_cidr_map = {for key, val in var.db_cidrs: val => val}
}

module "redshift" {
  source = "./redshift"
  db_name = var.db_name
  password = var.db_password
  db_spec = var.db_spec
  subnet_ids = [for key,val in module.subnets4db : val.id]
}

/*
module "sg4redshift" {
  source = "./security_group"
  vpc_id = module.vpc.id
}
*/