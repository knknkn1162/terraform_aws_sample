variable "instance_classes" {
  type = list(string)
}

variable "engine" {
  type = string
}

variable "engine_version" {
  type = string
}

data "aws_rds_orderable_db_instance" "example" {
  engine                     = var.engine
  engine_version = var.engine_version
  preferred_instance_classes = var.instance_classes
}

output "engine" {
  value = data.aws_rds_orderable_db_instance.example.engine
}

output "engine_version" {
  value = data.aws_rds_orderable_db_instance.example.engine_version
}

output "storage_type" {
  value = data.aws_rds_orderable_db_instance.example.storage_type
}

output "instance_class" {
  value = data.aws_rds_orderable_db_instance.example.instance_class
}

output "min_storage_size" {
  value = data.aws_rds_orderable_db_instance.example.min_storage_size
}