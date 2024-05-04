locals {
  filepath = "${path.module}/ec2/assets/certs/sample.pfx"
  filename = "sample.pfx"
  website_name = "Default Web Site"
}

data "local_file" "pfx" {
  filename = local.filepath
}


module "ami4ec2" {
  source = "./ec2/ami/windows_server"
  lang = "Japanese"
  ver = 2022
}

module "ec2" {
  source = "./ec2"
  ami = module.ami4ec2.id
  subnet_id = module.subnet4public.id
  vm_spec = var.ec2_spec
  sg_ids = [module.sg.id]
  enable_ssm = var.enable_ec2_ssm
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
New-WebBinding -Name "${local.website_name}" -IP "*" -Port 443 -HostHeader "${local.domain}" -Protocol https
(Get-WebBinding -Name "${local.website_name}" -Protocol https).AddSslCertificate($cert.GetCertHashString(),"my")
EOF
}

module "register_a_record" {
  source = "./dns_a_record"
  root_domain = var.root_domain
  prefix = var.prefix_domain
  ip = module.ec2.public_ip
}