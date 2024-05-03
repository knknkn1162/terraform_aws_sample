variable "services" {
  type = list(string)
}

variable "allow_policy_arns" {
  type = list(string)
}

resource "aws_iam_role" "example" {
  name = "iam-role-${uuid()}"
  # assume role is the kind of "resource base policy"
  assume_role_policy = module.assume_role_policy.json
  # "identity based policy"
  ## [allow/deny] [action] to [resource] with [condition]
  managed_policy_arns = var.allow_policy_arns
}

# delegate to services
module "assume_role_policy" {
  source = "./assume_role_policy/"
  services = var.services
}

output "name" {
  value = aws_iam_role.example.name
}

output "arn" {
  value = aws_iam_role.example.arn
}

output "id" {
  value = aws_iam_role.example.id
}