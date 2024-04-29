# role

```hcl
resource "aws_iam_role" "example" {
  assume_role_policy  = data.aws_iam_policy_document.assume_role_policy.json
  managed_policy_arns = [, ..]
}
```

||assume role|managed|
|---|---|---|
|ec2|`type="Service", identifiers=["ec2.amazonaws.com""]`||
|lambda|`type="Service", identifiers=["lambda.amazonaws.com"]`||
|API gateway|`type="Service", identifiers=["apigateway.amazonaws.com"]`|https://docs.aws.amazon.com/ja_jp/apigateway/latest/developerguide/permissions.html|
