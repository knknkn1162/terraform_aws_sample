/*
locals {
  AWSLambdaBasicExecutionRole = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

module "role4ec2" {
  source = "./role4service"
  services = ["apigateway.amazonaws.com"]
  allow_policy_arns = [local.AWSLambdaBasicExecutionRole]
}
*/