variable "cidr" {
  type = string
}

variable "server_acm_arn" {
  type = string
}

variable "root_acm_arn" {
  type = string
}

variable "log_group_name" {
  type = string
}

variable "log_stream_name" {
  type = string
}

resource "aws_cloudwatch_log_group" "example" {
  name              = var.log_group_name
  retention_in_days = 14
}

resource "aws_cloudwatch_log_stream" "example" {
  name           = var.log_stream_name
  log_group_name = aws_cloudwatch_log_group.example.name
}

resource "aws_ec2_client_vpn_endpoint" "example" {
  server_certificate_arn = var.server_acm_arn
  client_cidr_block      = var.cidr

  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = var.root_acm_arn
  }

  connection_log_options {
    enabled               = true
    cloudwatch_log_group  = aws_cloudwatch_log_group.example.name
    cloudwatch_log_stream = aws_cloudwatch_log_stream.example.name
  }
}