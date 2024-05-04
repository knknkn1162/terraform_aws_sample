module "vpn" {
  source = "./vpn"
  vpc_id = module.vpc1.id
  cgw_public_ip = module.vyos.public_ip
}


module "conf" {
  source = "./ec2/settings"
  tunnel1_ip = {
    tunnel = module.vpn.tunnel1_address
    cgw_cidr = module.vpn.tunnel1_cgw_inside_cidr
    vgw = module.vpn.tunnel1_vgw_inside_address
  }
  tunnel2_ip = {
    tunnel = module.vpn.tunnel2_address
    cgw_cidr = module.vpn.tunnel2_cgw_inside_cidr
    vgw = module.vpn.tunnel2_vgw_inside_address
  }
  vyos_private_ip = module.vyos.private_ip
  peer_vpc_cidr = module.vpc2.cidr
  filepath = local.local_filepath
}


resource "null_resource" "settings" {
  triggers = {
    endpoint = module.conf.id
  }
  connection {
    type        = "ssh"
    host        = module.vyos.public_ip
    user        = module.vyos.user
    private_key = module.vyos.ssh_privkey
  }
  provisioner "file" {
    source      = local.local_filepath
    destination = local.remote_filepath
  }
  provisioner "remote-exec" {
    # see https://developer.hashicorp.com/terraform/language/resources/provisioners/remote-exec
    inline = [
      "chmod +x ${local.remote_filepath}",
      "${local.remote_filepath}",
    ]
  }
}
