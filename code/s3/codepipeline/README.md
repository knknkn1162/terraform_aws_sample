+ codepipeline
  + source
    + Amazon S3
    + ECR
    + CodeCommit
    + CodeStarSourceConnection
  + build(ほぼcodebuild一択)
    + input: BITBUCKET, CODECOMMIT, CODEPIPELINE, GITHUB, GITHUB_ENTERPRISE, GITLAB, GITLAB_SELF_MANAGED, NO_SOURCE, S3
    + output: CODEPIPELINE, NO_ARTIFACTS, S3
  + test
    + Codebuild
  + deploy
    + codeDeploy -> ECS, Lambda, Server
    + S3
  + Invoke
    + AWS Lambda
    + AWS step functions

See also https://docs.aws.amazon.com/ja_jp/codepipeline/latest/userguide/reference-pipeline-structure.html#actions-valid-providers