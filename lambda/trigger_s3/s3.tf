module "s3" {
  source = "./s3"
  name = var.s3_name
  force_destroy = local.s3_force_destroy
}