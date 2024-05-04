output "tunnel1_address" {
  value = aws_vpn_connection.example.tunnel1_address
}

output "tunnel1_cgw_inside_cidr" {
  value = aws_vpn_connection.example.tunnel1_inside_cidr
}

output "tunnel1_vgw_inside_address" {
  value = aws_vpn_connection.example.tunnel1_vgw_inside_address
}


output "tunnel2_address" {
  value = aws_vpn_connection.example.tunnel2_address
}

output "tunnel2_cgw_inside_cidr" {
  value = aws_vpn_connection.example.tunnel2_inside_cidr
}

output "tunnel2_vgw_inside_address" {
  value = aws_vpn_connection.example.tunnel2_vgw_inside_address
}