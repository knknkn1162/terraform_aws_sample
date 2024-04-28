vpc_cidr = "10.0.0.0/16"
bastion_spec = "t2.small"
public_cidr = "10.0.1.0/24"
lambda_cidr = "10.0.2.0/24"

runtime = "nodejs20.x"
handler = "main.handler"
source_dir =  "./scripts/"
test_json_paths = []