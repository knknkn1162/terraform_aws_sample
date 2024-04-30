module "lambda" {
  source = "../helloworld"
  source_dir = "./lambda/scripts"
  handler = "main.handler"
  runtime = "nodejs20.x"
}

module "lambda_trigger" {
  source = "../helloworld/lambda/trigger"
  func_name = module.lambda.func_name
  principal = "apigateway.amazonaws.com"
  exec_arn = module.api_gateway.exec_arn
}