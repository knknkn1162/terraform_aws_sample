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
</powershell>
<persist>true</persist>
EOF
}

# egress only
module "natgw" {
  source = "../natgw"
  subnet_id = var.natgw_subnet_id
}

# route table(private)
resource "aws_route_table" "example" {
  vpc_id = var.vpc_id
}

resource "aws_route" "private" {
  route_table_id = aws_route_table.example.id
  nat_gateway_id = module.natgw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "example" {
  subnet_id = var.vm_subnet_id
  route_table_id = aws_route_table.example.id
}