data "aws_availability_zones" "example" {
}

locals {
  engine = "postgres"
}

module "postgres" {
  source = "./lookup"
  engine = local.engine
  engine_version = var.db_version
  # see https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Concepts.DBInstanceClass.html
  instance_classes = [var.spec]
}

resource "aws_db_subnet_group" "example" {
  name       = "subnet-group-${uuid()}"
  subnet_ids = var.subnet_ids
}

# aws_rds_cluster_instance
resource "aws_db_instance" "example" {
  allocated_storage    = module.postgres.min_storage_size
  db_name              = var.db_name
  engine               = module.postgres.engine
  engine_version       = module.postgres.engine_version
  instance_class       = module.postgres.instance_class
  username             = "adminuser"
  password             = var.password
  db_subnet_group_name = aws_db_subnet_group.example.name
  skip_final_snapshot  = true
  # deletion_protection = false # by default
}

/*
# use aws_rds_cluster instead of aws_db_instance in aurora
# see https://stackoverflow.com/questions/71207478/minimum-size-for-terraform-aurora-aws-db-instance#comment125872596_71208829
resource "aws_rds_cluster" "example" {
  engine                  = module.aurora_postgresql.engine
  availability_zones      = data.aws_availability_zones.example.names
  database_name           = var.db_name
  master_username         = "adminuser"
  master_password         = var.password
  # when provisioned, set serverlessv2_scaling_configuration block
  engine_mode = "serverless"
  skip_final_snapshot = true
  db_subnet_group_name = aws_db_subnet_group.example.name
  # Aurora Serverless currently doesn't support using a custom database port.
  # port = ...
  # enable_http_endpoint - (Optional) Enable HTTP endpoint (data API). Only valid when engine_mode is set to serverless.
  # To use the query editor for a database, the database must have the Data API enabled.
  enable_http_endpoint = true
}
*/

# aws_rds_cluster_instance is not necessary when engine_mode = serverless

output "endpoint" {
  value = aws_db_instance.example.address
}

output "port" {
  value = aws_db_instance.example.port
}

output "engine_version" {
  value = aws_db_instance.example.engine_version_actual
}

output "db_name" {
  value = aws_db_instance.example.db_name
}

output "psql_command" {
  value = "PGPASSWORD=${var.password} psql -h ${aws_db_instance.example.address} -U ${aws_db_instance.example.username} -p ${aws_db_instance.example.port} -d ${aws_db_instance.example.db_name}"
}