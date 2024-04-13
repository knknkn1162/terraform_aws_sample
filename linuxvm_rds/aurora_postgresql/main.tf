data "aws_availability_zones" "example" {
}

resource "aws_db_subnet_group" "example" {
  name       = "subnet-group-${uuid()}"
  subnet_ids = var.subnet_ids
}

module "aurora_postgresql" {
  source = "./lookup"
  engine = "aurora-postgresql"
  # see https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Concepts.DBInstanceClass.html
  instance_classes = ["db.serverless"]
}

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
}

# aws_rds_cluster_instance is not necessary when engine_mode = serverless

output "endpoint" {
  value = aws_rds_cluster.example.endpoint
}

output "port" {
  value = aws_rds_cluster.example.port
}

output "engine_version" {
  value = aws_rds_cluster.example.engine_version_actual
}

output "db_name" {
  value = aws_rds_cluster.example.database_name
}

output "psql_command" {
  value = "PGPASSWORD=${var.password} psql -h ${aws_rds_cluster.example.endpoint} -U ${aws_rds_cluster.example.master_username} -p ${aws_rds_cluster.example.port} -d ${aws_rds_cluster.example.database_name}"
}