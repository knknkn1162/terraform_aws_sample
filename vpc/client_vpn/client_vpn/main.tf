variable "cidr" {
  type = string
}

variable "server_acm_arn" {
  type = string
}

variable "client_arm_arn" {
  type = string
}

variable "log_group_name" {
  type = string
}

variable "log_stream_name" {
  type = string
}

variable "subnet_id" {
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
  split_tunnel = true
  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = var.client_arm_arn
  }

  connection_log_options {
    enabled               = true
    cloudwatch_log_group  = aws_cloudwatch_log_group.example.name
    cloudwatch_log_stream = aws_cloudwatch_log_stream.example.name
  }
}

resource "aws_ec2_client_vpn_network_association" "example" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.example.id
  subnet_id              = var.subnet_id
}

resource "aws_ec2_client_vpn_authorization_rule" "example" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.example.id
  target_network_cidr    = "0.0.0.0/0"
  authorize_all_groups   = true
}

output "transport_protocol" {
  value = aws_ec2_client_vpn_endpoint.example.transport_protocol
}

output "dns_name" {
  value = aws_ec2_client_vpn_endpoint.example.dns_name
}