variable "cert_filepath" {
  type = string
}

variable "privkey_filepath" {
  type = string
}

variable "chain_filepath" {
  type = string
}

resource "aws_acm_certificate" "cert" {
  private_key      = file(var.privkey_filepath)
  certificate_body = file(var.cert_filepath)
  certificate_chain = file(var.chain_filepath)
}

output "arn" {
  value = aws_acm_certificate.cert.arn
}

output "ca_arn" {
  value = aws_acm_certificate.cert.certificate_authority_arn
}