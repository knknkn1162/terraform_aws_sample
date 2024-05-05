variable "transport_protocol" {
  type = string
}

variable "dns_name" {
  type = string
}

variable "ca_crt_filepath" {
  type = string
}

variable "client_crt_filepath" {
  type = string
}

variable "client_key_filepath" {
  type = string
}

variable "client_pem_filepath" {
  type = string
}

variable "conf_filepath" {
  type = string
}

resource "local_file" "example" {
  content  = templatefile("${path.module}/client_config.ovpn.tftpl", {
    transport_protocol = var.transport_protocol,
    dns_name = startswith(var.dns_name, "*.") ? substr(var.dns_name, 2, -1) : var.dns_name
    ca_crt = file(var.ca_crt_filepath)
    client_crt = file(var.client_pem_filepath)
    client_key = file(var.client_key_filepath)
  })
  filename = var.conf_filepath
}