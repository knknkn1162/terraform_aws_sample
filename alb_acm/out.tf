output "alb_dns" {
  value = module.alb.alb_dns
}

output "alb_https_url" {
  value = "https://${module.alb.acm_dns}"
}