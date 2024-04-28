variable "services" {
  type = list(string)
}

variable "managed_policy_arns" {
  type = list(string)
}

module "service" {
  source = "./service"
  services = var.services
}

resource "aws_iam_role" "example" {
  name = "iam-role-${uuid()}"
  assume_role_policy = module.service.json
  managed_policy_arns = var.managed_policy_arns
}

output "name" {
  value = aws_iam_role.example.name
}

output "arn" {
  value = aws_iam_role.example.arn
}