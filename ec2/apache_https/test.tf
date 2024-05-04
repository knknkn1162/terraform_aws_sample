module "test" {
  source = "./test"
  trigger = module.ec2.id
  domain = local.domain
}