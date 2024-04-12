output "alb_dns" {
  value = module.alb.alb_dns
}

output "alb_https_url" {
  value = "https://${module.alb.acm_dns}"
}

output "ssh_privkey" {
  value = module.vm1.ssh_privkey
  sensitive = true
}