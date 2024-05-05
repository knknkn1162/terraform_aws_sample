variable "tunnel1" {
  type = map(string)
  validation {
    condition = alltrue([
      for key in keys(var.tunnel1) : contains(["tunnel_ip", "vgw_ip", "cgw_ip", "pre_shared_secret"],key)
    ])
    error_message = "tunnel vgw cgw_cidr  are necessary for tunnel1_ip"
  }
}

variable "tunnel2" {
  type = map(string)
  validation {
    condition = alltrue([
      for key in keys(var.tunnel2) : contains(["tunnel_ip", "vgw_ip", "cgw_ip", "pre_shared_secret"],key)
    ])
    error_message = "tunnel vgw cgw_cidr keys are necessary for tunnel2_ip"
  } 
}

variable "vyos_private_ip" {
  type = string
}

variable "peer_vpc_cidr" {
  type = string
}

variable "filepath" {
  type = string
}

resource "local_file" "example" {
  content  = templatefile("${path.module}/conf/vyos.conf.tftpl", {
    tunnel1_address = var.tunnel1.tunnel_ip,
    tunnel1_cgw_inside_address = var.tunnel1.cgw_ip,
    tunnel1_vgw_inside_address = var.tunnel1.vgw_ip,
    tunnel1_pre_shared_secret = var.tunnel1.pre_shared_secret,
    tunnel2_address = var.tunnel2.tunnel_ip,
    tunnel2_cgw_inside_address = var.tunnel2.cgw_ip,
    tunnel2_vgw_inside_address = var.tunnel2.vgw_ip,
    tunnel2_pre_shared_secret = var.tunnel2.pre_shared_secret,
    vyos_private_ip = var.vyos_private_ip,
    peer_vpc_cidr = var.peer_vpc_cidr
  })
  filename = var.filepath
}

output "id" {
  value = local_file.example.id
}