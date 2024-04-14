vpc_cidr = "10.0.0.0/16"
public_cidr = "10.0.1.0/24"
bastion_spec = "t2.small"
db_cidrs = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]
db_name = "mydb"
db_password = "***"
# `aws rds describe-db-engine-versions --engine sqlserver-web --query "DBEngineVersions[].EngineVersion"`
# see also https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraPostgreSQL.Updates.20180305.html
db_version = "15.00.4355.3.v1"
# see https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_SQLServer.html#SQLServer.Concepts.General.InstanceClasses
db_spec = "db.t3.small"
db_edition = "ex"