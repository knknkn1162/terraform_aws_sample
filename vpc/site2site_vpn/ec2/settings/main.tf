variable "tunnel1_ip" {
  type = map(string)
  validation {
    condition = alltrue([
      for key in keys(var.tunnel1_ip) : contains(["tunnel", "vgw", "cgw"],key)
    ])
    error_message = "tunnel vgw cgw_cidr  are necessary for tunnel1_ip"
  }
}

variable "tunnel2_ip" {
  type = map(string)
  validation {
    condition = alltrue([
      for key in keys(var.tunnel2_ip) : contains(["tunnel", "vgw", "cgw"],key)
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
    tunnel1_address = var.tunnel1_ip.tunnel,
    tunnel1_cgw_inside_address = var.tunnel1_ip.cgw,
    tunnel1_vgw_inside_address = var.tunnel1_ip.vgw,
    tunnel2_address = var.tunnel2_ip.tunnel,
    tunnel2_cgw_inside_address = var.tunnel2_ip.cgw,
    tunnel2_vgw_inside_address = var.tunnel2_ip.vgw,
    vyos_private_ip = var.vyos_private_ip,
    peer_vpc_cidr = var.peer_vpc_cidr
  })
  filename = var.filepath
}

output "id" {
  value = local_file.example.id
}