data "aws_availability_zones" "example" {
}

locals {
  engine = "sqlserver-${var.edition}"
}

module "db_info" {
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
  allocated_storage    = module.db_info.min_storage_size
  # see "DBName" in https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_CreateDBInstance.html
  # db_name              = null
  engine               = module.db_info.engine
  engine_version       = module.db_info.engine_version
  instance_class       = module.db_info.instance_class
  username             = "adminuser"
  password             = var.password
  db_subnet_group_name = aws_db_subnet_group.example.name
  skip_final_snapshot  = true
  # deletion_protection = false # by default
}

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

output "connection_command" {
  value = "sqlcmd -S ${aws_db_instance.example.address} -U ${aws_db_instance.example.username} -P ${var.password}"
}

output "id" {
  value = aws_db_instance.example.id
}