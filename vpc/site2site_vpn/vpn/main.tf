variable "vpc_id" {
  type = string
}

variable "cgw_public_ip" {
  type = string
}


# main
module "vpn_gateway" {
  source = "./vpn_gateway"
  vpc_id = var.vpc_id
}

# peer
module "customer_gateway" {
  source = "./customer_gateway"
  public_ip = var.cgw_public_ip
}

resource "aws_vpn_connection" "example" {
  vpn_gateway_id      = module.vpn_gateway.id
  customer_gateway_id = module.customer_gateway.id
  type                = module.customer_gateway.type
  # default to false
  #static_routes_only  = false
}