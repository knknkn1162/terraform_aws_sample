variable "rest_api_id" {
  type = string
}

variable "vpce_id" {
  type = string
}

variable "exec_arn" {
  type = string
}

# see https://docs.aws.amazon.com/apigateway/latest/developerguide/private-api-tutorial.html#private-api-tutorial-attach-resource-policy

data "aws_iam_policy_document" "allow" {
  statement {
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions   = ["execute-api:Invoke"]
    resources = ["execute-api:/*"]
    condition {
      test = "StringEquals"
      variable = "aws:sourceVpce"
      values = [var.vpce_id]
    }
  }
}

resource "aws_api_gateway_rest_api_policy" "example" {
  rest_api_id = var.rest_api_id
  policy      = data.aws_iam_policy_document.allow.json
}

output "id" {
  value = aws_api_gateway_rest_api_policy.example.id
}