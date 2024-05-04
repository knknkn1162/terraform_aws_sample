locals {
  fqdn = "${var.prefix}.${var.domain}"
  target_origin_id = "origin-${uuid()}"
  target_fqdn = "${var.prefix}.${var.target_domain}"
}

data "aws_cloudfront_cache_policy" "example" {
  # AWS managed cache policy names are prefixed with Managed-:
  name = "Managed-CachingOptimized"
}

module "acm" {
  source = "./acm"
  domain = var.domain
}

# Cloudfront
resource "aws_cloudfront_distribution" "example" {
  enabled = true
  # to avoid ERR_SSL_VERSION_OR_CIPHER_MISMATCH
  aliases = [local.fqdn]
  # target
  origin {
    domain_name = local.target_fqdn
    origin_id   = local.target_origin_id
    custom_origin_config {
      origin_protocol_policy = "match-viewer"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
      http_port              = 80
      https_port             = 443
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn      = module.acm.arn
    # allows multiple secure (HTTPS) websites (or any other service over TLS) to be served by the same IP address
    # without requiring all those sites to use the same certificate.
    ssl_support_method       = "sni-only"
  }

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]
    target_origin_id       = local.target_origin_id
    viewer_protocol_policy = "redirect-to-https"
    cache_policy_id = data.aws_cloudfront_cache_policy.example.id
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations = []
    }
  }
}

# add A record after creating cloudfront resource
resource "aws_route53_record" "cloudfront" {
  zone_id = module.acm.zone_id
  name    = local.fqdn
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.example.domain_name
    zone_id                = aws_cloudfront_distribution.example.hosted_zone_id
    evaluate_target_health = false
  }
}

output "domain" {
  value = aws_cloudfront_distribution.example.domain_name
}

output "fqdn" {
  value = aws_route53_record.cloudfront.fqdn
}