locals {
  txt_prefix = "_amazonses"
}

module "zone" {
  source = "./data_zone"
  domain = var.domain
}

resource "aws_ses_domain_identity" "example" {
  domain = module.zone.name
}

resource "aws_route53_record" "txt" {
  zone_id = module.zone.zone_id
  name    = "${local.txt_prefix}.${module.zone.name}"
  type    = "TXT"
  ttl     = "60"
  records = [aws_ses_domain_identity.example.verification_token]
}

# DKIM authentication takes max 72 hours when trying to confirm SES domain authentication
# so we don't do DKIM settings
resource "aws_ses_domain_identity_verification" "example" {
  count = var.enable_verification ? 1 : 0
  domain = aws_ses_domain_identity.example.id
  depends_on = [aws_route53_record.txt]
}

output "txt_value" {
  value = aws_ses_domain_identity.example.verification_token
}