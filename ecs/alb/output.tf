output "arn" {
  value = aws_lb.example.arn
}

output "tg_arn" {
  value = aws_lb_target_group.example.arn
}

output "fqdn" {
  value = aws_lb.example.dns_name
}