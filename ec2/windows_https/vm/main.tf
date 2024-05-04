module "ami4vm" {
  source = "../ami/windows_server"
  ver = 2022
  lang = "English"
  has_gui = false
}

resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "example" {
  public_key = tls_private_key.pk.public_key_openssh
}

resource "aws_instance" "vm" {
  ami                    = module.ami4vm.id
  instance_type          = var.vm_spec
  subnet_id              = var.vm_subnet_id
  # get_password_date is valid only Windows
  key_name = aws_key_pair.example.key_name
  vpc_security_group_ids = var.security_group_ids
  user_data = <<-EOF
<powershell>
${var.user_data}
echo $null >> signal
</powershell>
<persist>true</persist>
EOF
}