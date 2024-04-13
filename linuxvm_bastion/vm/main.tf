variable "vm_spec" {
  type = string
}
variable "vm_cidr" {
  type = string
}

variable "vm_subnet_id" {
  type = string
}

variable "natgw_subnet_id" {
  type = string
}

variable "vpc_id" {
  type = string
}

module "ami4vm" {
  source = "../ami/amzn_linux_2023"
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

output "ssh_command" {
  value = "ssh -i key.pem ec2-user@${aws_instance.vm.private_ip}"
}

output "vm_user" {
  # see https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/connect-to-linux-instance.html
  value = "ec2-user"
}

output "ssh_privkey" {
  value = tls_private_key.pk.private_key_pem
}

output "natgw_public_ip" {
  value = module.natgw.public_ip
}