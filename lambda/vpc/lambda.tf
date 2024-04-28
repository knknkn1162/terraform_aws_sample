module "subnet4lambda" {
  source = "./subnet"
  cidr = var.lambda_cidr
  vpc_id = module.vpc.id
}

# https://docs.aws.amazon.com/lambda/latest/dg/configuration-vpc.html#configuration-vpc-permissions
data "aws_iam_policy" "AWSLambdaVPCAccessExecutionRole" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

data "aws_iam_policy" "AWSLambdaENIManagementAccess" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaENIManagementAccess"
}

module "lambda" {
  source = "./lambda"
  runtime = var.runtime
  handler = var.handler
  source_dir = var.source_dir
  subnet_ids = [module.subnet4lambda.id]
  sg_ids = []
  allow_policy_arns = [
    data.aws_iam_policy.AWSLambdaENIManagementAccess.arn,
    data.aws_iam_policy.AWSLambdaVPCAccessExecutionRole.arn
  ]
}

resource "aws_lambda_function_url" "test_latest" {
  function_name      = module.lambda.func_name
  authorization_type = "NONE"
}