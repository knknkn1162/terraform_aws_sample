output "alb_url" {
  value = "http://${module.alb.dns}"
}