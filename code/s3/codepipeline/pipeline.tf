module "pipeline" {
  source = "./pipeline"
  pipeline_policy_json = data.aws_iam_policy_document.example.json
  artifact_s3 = aws_s3_bucket.artifact.bucket
  source_conf = {
    S3Bucket    = module.source.name
    S3ObjectKey = var.source_s3_key
    PollForSourceChanges = true
  }
  build_conf = {
    ProjectName = module.build.name
  }

  deploy_conf = {
    BucketName = module.deploy.name
    Extract = true
  }
  depends_on = [
    null_resource.upload_source_s3
  ]
}

data "aws_iam_policy_document" "example" {
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