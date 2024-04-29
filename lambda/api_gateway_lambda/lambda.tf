module "lambda" {
  source = "../helloworld"
  source_dir = "./lambda/scripts"
  handler = "main.handler"
  runtime = "nodejs20.x"
}

# avoid "Invalid permissions on Lambda function" error
module "trigger" {
  source = "./api_gateway/trigger"
  func_name = module.lambda.func_name
  exec_arn = module.deployment.exec_arn
}