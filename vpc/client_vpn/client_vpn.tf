module "server_acm" {
  source = "./acm/import"
  cert_filepath = "${path.module}/assets/server.crt"
  privkey_filepath = "${path.module}/assets/server.key"
  chain_filepath = "${path.module}/assets/ca.crt"
}

module "client_acm" {
  source = "./acm/import"
  cert_filepath = "${path.module}/assets/client1.domain.tld.crt"
  privkey_filepath = "${path.module}/assets/client1.domain.tld.key"
  chain_filepath = "${path.module}/assets/ca.crt"
}

module "client_vpn" {
  source = "./client_vpn"
  cidr = module.subnet4vpn_client.cidr
  log_group_name = "/aws/cvpn"
  log_stream_name = "sample-${uuid()}"
  server_acm_arn = module.server_acm.arn
  root_acm_arn = module.client_acm.arn
}