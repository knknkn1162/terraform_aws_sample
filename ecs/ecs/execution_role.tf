data "aws_iam_role" "ecsTaskExecutionRole" {
  name = "ecsTaskExecutionRole"
}

data "aws_iam_policy" "AmazonEC2ContainerRegistryReadOnly" {
  name = "AmazonEC2ContainerRegistryReadOnly"
}

data "aws_iam_policy" "AmazonECSTaskExecutionRolePolicy" {
  name = "AmazonECSTaskExecutionRolePolicy"
}

# to docker pull, AmazonEC2ContainerRegistryReadOnly is necessary
resource "aws_iam_role" "example" {
  assume_role_policy = data.aws_iam_role.ecsTaskExecutionRole.assume_role_policy
  managed_policy_arns = [
    data.aws_iam_policy.AmazonEC2ContainerRegistryReadOnly.arn,
    data.aws_iam_policy.AmazonECSTaskExecutionRolePolicy.arn
  ]
}