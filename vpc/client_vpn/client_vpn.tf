locals {
  server_cert_filepath = "${path.module}/assets/server.crt"
  server_privkey_filepath = "${path.module}/assets/server.key"
  client_cert_filepath = "${path.module}/assets/client1.domain.tld.crt"
  client_pem_filepath = "${path.module}/assets/client1.domain.tld.pem"
  client_privkey_filepath = "${path.module}/assets/client1.domain.tld.key"
  ca_crt_filepath = "${path.module}/assets/ca.crt"

}

# see https://docs.aws.amazon.com/ja_jp/vpn/latest/clientvpn-admin/mutual.html
module "server_acm" {
  source = "./acm/import"
  cert_filepath = local.server_cert_filepath
  privkey_filepath = local.server_privkey_filepath
  chain_filepath = local.ca_crt_filepath
}

module "client_acm" {
  source = "./acm/import"
  cert_filepath = "${path.module}/assets/client1.domain.tld.crt"
  privkey_filepath = "${path.module}/assets/client1.domain.tld.key"
  chain_filepath = local.ca_crt_filepath
}

module "client_vpn" {
  source = "./client_vpn"
  cidr = var.client_vpn_endpoint_cidr
  log_group_name = "/aws/cvpn"
  log_stream_name = "sample-${uuid()}"
  server_acm_arn = module.server_acm.arn
  client_arm_arn = module.client_acm.arn
  subnet_id = module.subnet4client_vpn.id
}

module "gen_conf" {
  source = "./client_vpn/conf"
  transport_protocol = module.client_vpn.transport_protocol
  dns_name = module.client_vpn.dns_name
  ca_crt_filepath = local.ca_crt_filepath
  client_crt_filepath = local.client_cert_filepath
  client_key_filepath = local.client_privkey_filepath
  client_pem_filepath = local.client_pem_filepath
  conf_filepath = var.conf_filepath

}