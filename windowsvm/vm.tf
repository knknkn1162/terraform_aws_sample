locals {
  filepath = "${path.module}/assets/sample.pfx"
  filename = "sample.pfx"
  website_name = "Default Web Site"
}

data "local_file" "pfx" {
  filename = local.filepath
}

resource "aws_security_group" "example" {
  vpc_id      = module.vpc.id
}


module "egress" {
  source = "./security_group/egress/all"
  security_group_id = aws_security_group.example.id
  is_any_cidr = true
}


module "ingress" {
  source = "./security_group/ingress"
  security_group_id = aws_security_group.example.id
  is_any_cidr = true
  ports = [443, 3389]
}

# we don't have to use aws_eip_association because it's already associated with vm
resource "aws_eip" "example" {
  instance = module.vm.id
  domain   = "vpc"
}

module "vm" {
  source = "./vm"
  vpc_id = module.vpc.id
  vm_subnet_id = module.subnet4public.id
  vm_spec = var.vm_spec
  vm_cidr = var.public_cidr
  security_group_ids = [aws_security_group.example.id]
  user_data = <<-EOF
cd ("{0}/documents" -f $env:PUBLIC)
# import pfx
$bytes = [System.Convert]::FromBase64String("${data.local_file.pfx.content_base64}")
[System.IO.File]::WriteAllBytes("$pwd/${local.filename}", $bytes)
$password = ConvertTo-SecureString -AsPlainText -Force "${var.pfx_password}"
$cert = Import-PfxCertificate -FilePath "${local.filename}" -CertStoreLocation Cert:\LocalMachine\My -Password $password
Import-module servermanager
Add-WindowsFeature Web-Server -IncludeManagementTools -IncludeAllSubFeature
Import-Module WebAdministration
# bind pfx <-> var.dns_prefix.domain
New-WebBinding -Name "${local.website_name}" -IP "*" -Port 443 -HostHeader "${var.dns_prefix}.${var.root_domain}" -Protocol https
(Get-WebBinding -Name "${local.website_name}" -Protocol https).AddSslCertificate($cert.GetCertHashString(),"my")
EOF
}