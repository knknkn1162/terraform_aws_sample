locals {
  filename = "sample.txt"
}

module "test1" {
  source = "./tests/test1"
  filename = local.filename
  s3_name = module.s3.name
  lambda_func_name = module.lambda.func_name
}

module "test2" {
  source = "./tests/test2"
  s3_name = module.s3.name
  filename = local.filename
  triggers = {
    ref = module.lambda.id
  }
}

output "test_result" {
  value = module.test1.results1
}