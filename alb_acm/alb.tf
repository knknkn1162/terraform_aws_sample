variable "domain" {
  type = string
}

variable "prefix" {
  type = string
}

module "alb" {
  source = "./alb2vm_acm"
  vpc_id = module.vpc.id
  # At least two subnets in two different Availability Zones must be specified
  subnet_ids = [module.subnet4public1.id, module.subnet4public2.id]
  backend_vm_ids = [module.vm1.id]
  domain = var.domain
  prefix = var.prefix
}