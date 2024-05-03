variable "services" {
  type = list(string)
}

# リソースベースのポリシーは、アタッチされているリソースに適用されるためResourceが必要ない代わりに、適用対象をPrincipalで指定します。
data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    # Statements without a sid cannot be overridden.
    # sid = ""
    # https://dev.classmethod.jp/articles/trustpolicy-wildcard-check/
    principals {
      # AWS(account, role, user), Service(AWS service), Federated, CanonicalUser and *.
      type        = "Service"
      identifiers = var.services
    }
  }
}

output "json" {
  value = data.aws_iam_policy_document.assume_role_policy.json
}