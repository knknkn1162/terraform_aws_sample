# 権限周り

+ AWS lambda
  + aws_lambda_permission
    + lambdaを実行するサービスに対して付与
      + 例1: API gatewayがlambda functionを呼び出す時
        + aws_lambda_permission.principal = "apigateway.amazonaws.com"を指定
  + aws_lambda_function.role
    + assume_role_policy = "lambda.amazonaws.com"を指定する
    + managed_policy_arns: lambda functionからアクセスするサービスに対して付与する
      + 例1: lambda function内でS3を操作する
      + 例2: lambda functionにてlogをcloudwatchで生成する
      + 例3: lambda functionにてDynamoDBの操作を行う
      + 例4: lambda functionにてSESを使ってメール送信する
        + AmazonSESFullAccessなど
  + aws_lambda_function.logging_config
    + 遷移先のCloudwatchとの連携で使う
+ 連携サービスの権限付与
  + AWS Gateway
    + lambda functionを実行するために使用
      + aws_api_gateway_rest_api_policy: API gatewayを使用するsrcの権限を指定
        + 例1: VPC endpointはAPI gatewayのAPIを叩く
  + S3
    + triggerとして
      + S3自体には権限の付与は必要ない
  + cloudwatch
    + 遷移先として
      + cloudwatch自体には権限の付与は必要ない
  + SQS
    + triggerとして
    + 送信先として