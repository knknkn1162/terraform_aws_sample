data "aws_iam_policy_document" "codepipeline_policy" {
  statement {
    sid    = ""
    effect = "Allow"

    actions = [
      "codedeploy:CreateDeployment",
      "codedeploy:GetApplication",
      "codedeploy:GetApplicationRevision",
      "codedeploy:GetDeployment",
      "codedeploy:GetDeploymentConfig",
      "codedeploy:RegisterApplicationRevision"
    ]

    resources = ["*"]
  }

  statement {
    sid    = ""
    effect = "Allow"

    actions = [
      "elasticbeanstalk:*",
      "ec2:*",
      "elasticloadbalancing:*",
      "autoscaling:*",
      "cloudwatch:*",
      "s3:*",
      "sns:*",
      "cloudformation:*",
      "rds:*",
      "sqs:*",
      "ecs:*"
    ]

    resources = ["*"]
  }

  statement {
    sid    = ""
    effect = "Allow"

    actions = [
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "example" {
  name = "iam-policy-${uuid()}"
  policy = data.aws_iam_policy_document.codepipeline_policy.json
}

module "role4pipeline" {
  source = "../../role4service"
  services = ["codepipeline.amazonaws.com"]
  allow_policy_arns = [
    aws_iam_policy.default.example
  ]
}