module "vpc" {
  source = "./vpc"
  cidr = var.vpc_cidr
  enable_dns_hostnames = true
}

module "vpc_endpoint" {
  source = "./vpc/endpoint"
  vpc_id = module.vpc.id
  subnet_ids = [module.subnet4gateway.id]
  sg_ids = [aws_security_group.example.id]
  target_exec_arn = module.deployment.exec_arn
}

module "subnet4gateway" {
  source = "./subnet"
  vpc_id = module.vpc.id
  cidr = var.gateway_cidr
}