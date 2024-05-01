variable "rest_api_id" {
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
  }
}
/*
data "aws_iam_policy_document" "deny" {
  statement {
    effect = "Deny"
  }
  principals {
    type        = "*"
    identifiers = ["*"]
  }
}
*/


resource "aws_api_gateway_rest_api_policy" "test" {
  rest_api_id = var.rest_api_id
  policy      = data.aws_iam_policy_document.allow.json
}