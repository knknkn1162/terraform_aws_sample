variable "db_name" {
  type = string
}

variable "password" {
  type = string
}

variable "db_spec" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

/*
resource "aws_redshift_parameter_group" "tf-test-parameter-group" {
    name = "tf-test"
    family = "redshift-1.0"
    description = "Test parameter group for terraform"
    parameter {
      name = "require_ssl"
      value = "true"
    }
    parameter{
      name = "enable_user_activity_logging"
      value = "true"
    }
}
*/


resource "aws_redshift_cluster" "example" {
  cluster_identifier = "redshift-cluster-${uuid()}"
  database_name      = "mydb"
  master_username    = "adminuser"
  master_password    = var.password
  node_type          = var.db_spec
  cluster_type       = "single-node"
  cluster_subnet_group_name = aws_redshift_subnet_group.example.name
}


resource "aws_redshift_subnet_group" "example" {
  name       = "subnet-group-${uuid()}"
  subnet_ids = var.subnet_ids
}