variable "spec" {
  type = string
}

variable "image" {
  type = string
}

module "role4codebuild" {
  source = "../role4service"
  services = ["codebuild.amazonaws.com"]
  allow_policy_arns = [
    aws_iam_policy.example.arn
  ]
}


resource "aws_codebuild_project" "example" {
  name          = "codebuild-${uuid()}"
  service_role  = module.role4codebuild.arn

  artifacts {
    # CODEPIPELINE, NO_ARTIFACTS, S3.
    type = "CODEPIPELINE"
  }

  environment {
    # https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-compute-types.html
    compute_type                = var.spec
    # see https://docs.aws.amazon.com/ja_jp/codebuild/latest/userguide/build-env-ref-available.html
    image                       = var.image
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = false
  }

  source {
    # BITBUCKET, CODECOMMIT, CODEPIPELINE, GITHUB, GITHUB_ENTERPRISE, GITLAB, GITLAB_SELF_MANAGED, NO_SOURCE, S3
    type = "CODEPIPELINE"
  }
}

resource "aws_iam_policy" "example" {
  policy = data.aws_iam_policy_document.codebuild_policy.json
}

data "aws_iam_policy_document" "codebuild_policy" {
  statement {
    sid    = ""
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = ["*"]
  }

  statement {
    sid    = ""
    effect = "Allow"

    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeDhcpOptions",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeVpcs"
    ]

    resources = ["*"]
  }

  statement {
    sid    = ""
    effect = "Allow"

    actions = [
      "s3:*"
    ]

    resources = ["*"]
  }
}

output "name" {
  value = aws_codebuild_project.example.name
}