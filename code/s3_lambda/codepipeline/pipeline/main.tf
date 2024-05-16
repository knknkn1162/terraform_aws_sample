resource "aws_codepipeline" "codepipeline" {
  name     = "codepipeline-${uuid()}"
  role_arn = module.role4pipeline.arn

  artifact_store {
    location = var.artifact_sttore_location
    type     = "S3"
  }

  # https://docs.aws.amazon.com/ja_jp/codepipeline/latest/userguide/action-reference-S3.html
  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "S3"
      version          = "1"
      output_artifacts = ["source"]

      # see https://docs.aws.amazon.com/codepipeline/latest/userguide/action-reference-S3.html
      configuration = var.source_conf
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source"]
      output_artifacts = ["build"]
      version          = "1"
      # see https://docs.aws.amazon.com/ja_jp/codepipeline/latest/userguide/action-reference-CodeBuild.html
      configuration = {
        ProjectName = module.build.name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name             = "Deploy"
      category         = "Deploy"
      owner            = "AWS"
      provider         = "S3"
      version          = "1"
      input_artifacts = ["build"]

      # see https://docs.aws.amazon.com/codepipeline/latest/userguide/action-reference-S3.html
      configuration = {
        BucketName    = aws_s3_bucket.target.bucket
        Extract = true
      }
    }
  }
}