output "alb_fqdn" {
  value = module.alb.alb_dns
}

output "alb_https_url" {
  value = "https://${module.alb.acm_dns}"
}

output "cloudfront_fqdn" {
  value = module.cloudfront.fqdn
}