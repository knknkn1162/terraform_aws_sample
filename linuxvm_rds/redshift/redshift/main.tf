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


resource "aws_redshift_cluster" "example" {
  cluster_identifier = "redshift-cluster-${uuid()}"
  database_name      = "mydb"
  master_username    = "adminuser"
  master_password    = var.password
  node_type          = var.db_spec
  cluster_type       = "single-node"
}

resource "aws_redshift_subnet_group" "foo" {
  name       = "subnet-group-${uuid()}"
  subnet_ids = var.subnet_ids
}