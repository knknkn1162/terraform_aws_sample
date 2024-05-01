variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "sg_ids" {
  type = list(string)
}

variable "target_exec_arn" {
  type = string
}

data "aws_region" "current" {}

resource "aws_vpc_endpoint" "example" {
  # Leaving private DNS enabled is the recommended choice. If you choose not to enable private DNS, you're only able to access your API via public DNS.
  # see also https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-private-apis.html#apigateway-private-api-set-up-resource-policy
  private_dns_enabled = true
  security_group_ids  = var.sg_ids
  service_name        = "com.amazonaws.${data.aws_region.current.name}.execute-api"
  subnet_ids          = var.subnet_ids
  vpc_endpoint_type   = "Interface"
  vpc_id              = var.vpc_id
}

# see https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-vpc-endpoint-policies.html
data "aws_iam_policy_document" "allow" {
  statement {
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions   = ["execute-api:Invoke"]
    # "/*" is needed
    resources = ["${var.target_exec_arn}/*"]
  }
}

resource "aws_vpc_endpoint_policy" "example" {
  vpc_endpoint_id = aws_vpc_endpoint.example.id
  policy = data.aws_iam_policy_document.allow.json
}

output "id" {
  value = aws_vpc_endpoint.example.id
}