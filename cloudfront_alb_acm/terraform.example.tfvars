vpc_cidr = "10.0.0.0/16"
vm_spec = "t2.small"
vm1_cidr = "10.0.1.0/24"

natgw_cidr = "10.0.100.0/24"
public1_cidr = "10.0.101.0/24"
public2_cidr = "10.0.102.0/24"
# prepare to issue by ACM(*.${alb_domain}) in advance.
prefix = "***"
alb_domain = "***"
# prepare to issue by ACM(*.${cloudfront_domain}) in virginia
cloudfront_domain = "***"