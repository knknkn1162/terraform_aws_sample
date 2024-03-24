module "alb" {
  source = "./alb2vm_acm"
  vpc_id = module.vpc.id
  # At least two subnets in two different Availability Zones must be specified
  subnet_ids = [module.subnet4public1.id, module.subnet4public2.id]
  backend_vm_ids = [module.vm1.id]
  domain = var.alb_domain
  prefix = var.prefix
}

module "cloudfront" {
  source = "./cloudfront2alb"
  prefix = var.prefix
  domain = var.cloudfront_domain
  target_domain = var.alb_domain
}