locals {
  filename = "sample.txt"
}

module "test2" {
  source = "./tests/test2"
  s3_name = module.s3.name
  filename = local.filename
  triggers = {
    ref = module.lambda.id
  }
}

module "test1" {
  source = "./tests/test1"
  filename = local.filename
  s3_name = module.s3.name
  lambda_func_name = module.lambda.func_name
  depends_on = [
    module.test2
  ]
}

output "test_result" {
  value = module.test1.results1
}