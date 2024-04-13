vpc_cidr = "10.0.0.0/16"
public_cidr = "10.0.1.0/24"
bastion_spec = "t2.small"
db_cidrs = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]
db_name = "mydb"
db_password = "***"
# `aws rds describe-db-engine-versions --engine oracle-se2 --query "DBEngineVersions[].EngineVersion"`
db_version = "19.0.0.0.ru-2024-01.rur-2024-01.r1"
# see https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html#Concepts.DBInstanceClass.Support
db_spec = "db.m5.large"
is_oracledb_enterprise = false