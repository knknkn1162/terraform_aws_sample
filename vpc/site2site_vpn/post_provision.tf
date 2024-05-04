module "post_provision" {
  source = "./post_provision"
  ec2_id = module.vyos.id
}