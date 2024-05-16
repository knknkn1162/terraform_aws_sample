
resource "aws_iam_policy" "example" {
  name = "iam-policy-${uuid()}"
  policy = var.pipeline_policy_json
}

module "role4pipeline" {
  source = "../role4service"
  services = ["codepipeline.amazonaws.com"]
  allow_policy_arns = [
    aws_iam_policy.example.arn
  ]
}